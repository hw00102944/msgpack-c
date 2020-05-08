#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <msgpack.h>
#include <cjson/cJSON.h>

#define DEBUG(...) printf(__VA_ARGS__)

static void print(char const *buf, unsigned int len)
{
    size_t i = 0;
    for (; i < len; ++i)
        printf("%02x ", 0xff & buf[i]);
    printf("\n");
}

static inline int msgpack_pack_str_intact(msgpack_packer* pk, const void* b, size_t l)
 {
     int ret = msgpack_pack_str(pk, l);
     if (ret != 0) { return ret; }
     return msgpack_pack_str_body(pk, b, l);
 }

 static inline int msgpack_pack_bin_intact(msgpack_packer* pk, const void* b, size_t l)
 {
     int ret = msgpack_pack_bin(pk, l);
     if (ret != 0) { return ret; }
     return msgpack_pack_bin_body(pk, b, l);
 }

 static inline int msgpack_pack_ext_intact(msgpack_packer* pk, const void* b, size_t l, int8_t type)
 {
     int ret = msgpack_pack_ext(pk, l, type);
     if (ret != 0) { return ret; }
     return msgpack_pack_ext_body(pk, b, l);
 }

/*
 * Pack cJSON object.
 * return 0 success, -1 failed
 */
static int parse_cjson_object(msgpack_packer *pk, cJSON *node)
{
    int sz, i;
    size_t len;
    cJSON *child;

    if (node == NULL) {
        return -1;
    }

    switch (node->type & 0xFF) {
    case cJSON_Invalid:
        return -1;

    case cJSON_False:
        return msgpack_pack_false(pk);

    case cJSON_True:
        return msgpack_pack_true(pk);

    case cJSON_NULL:
        return msgpack_pack_nil(pk);

    case cJSON_String:
    case cJSON_Raw:
        len = strlen(node->valuestring);
        return msgpack_pack_str_intact(pk, node->valuestring, len);

    case cJSON_Number:
        if (isnan(node->valuedouble) || isinf(node->valuedouble)) {
            return msgpack_pack_nil(pk);
        }
        if (fabs(0.0) < fabs(node->valuedouble - node->valueint)) {
            return msgpack_pack_double(pk, node->valuedouble);
        } else {
            return msgpack_pack_int(pk, node->valueint);
        }

    case cJSON_Array:
        sz = cJSON_GetArraySize(node);
        if (msgpack_pack_array(pk, sz) != 0) {
            return -1;
        }
        for (i = 0; i < sz; i++) {
            if (parse_cjson_object(pk, cJSON_GetArrayItem(node, i)) < 0) {
                return -1;
            }
        }
        return 0;

    case cJSON_Object:
        sz = cJSON_GetArraySize(node);
        if (msgpack_pack_map(pk, sz) != 0) {
            return -1;
        }
        for (i = 0; i < sz; i++) {
            child = cJSON_GetArrayItem(node, i);
            len = strlen(child->string);
            if (msgpack_pack_str_intact(pk, child->string, len) != 0) {
                return -1;
            }
            if (parse_cjson_object(pk, child) != 0) {
                return -1;
            }
        }
        return 0;

    default:
        DEBUG("unknown type.\n");
        return -1;
    }
}

/*
 * Pack json string to msgpack format data.
 * return 0 success, -1 failed
 */
int msgpack_pack_jsonstr(msgpack_packer *pk, const char *jsonstr)
{
    int status;
    cJSON *node;
    const char *end = NULL;

    if (pk == NULL || jsonstr == NULL) {
        return -1;
    }

    node = cJSON_ParseWithOpts(jsonstr, &end, 1);
    if (node == NULL) {
        DEBUG("parse error: unexpected string `%s`\n", end);
        return -1;
    }
    status = parse_cjson_object(pk, node);
    cJSON_Delete(node);

    return status;
}

static int bin_contains_zero(const msgpack_object_bin *bin)
{
    size_t i;
    for (i = 0; i < bin->size; i++) {
        if (bin->ptr[i] == 0) {
            return 1;
        }
    }
    return 0;
}

#define PRINT_JSONSTR_CALL(ret, func, aux_buffer, aux_buffer_size, ...)   \
    ret = func(aux_buffer, aux_buffer_size, __VA_ARGS__);                 \
    if (ret < 0) return ret;                                              \
    if (ret > (int)aux_buffer_size) return 0;                             \
    aux_buffer = aux_buffer + ret;                                        \
    aux_buffer_size = aux_buffer_size - ret

/*
 * Convert msgpack format data to json string.
 * return >0: success, 0: length of buffer not enough, -1: failed
 */
int msgpack_object_print_jsonstr(char *buffer, size_t length, const msgpack_object o)
{
    char *aux_buffer = buffer;
    size_t aux_buffer_size = length;
    int ret;

    switch(o.type) {
    case MSGPACK_OBJECT_NIL:
        PRINT_JSONSTR_CALL(ret, snprintf, aux_buffer, aux_buffer_size, "null");
        break;

    case MSGPACK_OBJECT_BOOLEAN:
        PRINT_JSONSTR_CALL(ret, snprintf, aux_buffer, aux_buffer_size, (o.via.boolean ? "true" : "false"));
        break;

    case MSGPACK_OBJECT_POSITIVE_INTEGER:
#if defined(PRIu64)
        PRINT_JSONSTR_CALL(ret, snprintf, aux_buffer, aux_buffer_size, "%" PRIu64, o.via.u64);
#else
        if (o.via.u64 > ULONG_MAX) {
            PRINT_JSONSTR_CALL(ret, snprintf, aux_buffer, aux_buffer_size, "%lu", ULONG_MAX);
        }else {
            PRINT_JSONSTR_CALL(ret, snprintf, aux_buffer, aux_buffer_size, "%lu", (unsigned long)o.via.u64);
        }
#endif
        break;

    case MSGPACK_OBJECT_NEGATIVE_INTEGER:
#if defined(PRIi64)
        PRINT_JSONSTR_CALL(ret, snprintf, aux_buffer, aux_buffer_size, "%" PRIi64, o.via.i64);
#else
        if (o.via.i64 > LONG_MAX) {
            PRINT_JSONSTR_CALL(ret, snprintf, aux_buffer, aux_buffer_size, "%ld", LONG_MAX);
        } else if (o.via.i64 < LONG_MIN) {
            PRINT_JSONSTR_CALL(ret, snprintf, aux_buffer, aux_buffer_size, "%ld", LONG_MIN);
        } else {
            PRINT_JSONSTR_CALL(ret, snprintf, aux_buffer, aux_buffer_size, "%ld", (signed long)o.via.i64);
        }
#endif
        break;

    case MSGPACK_OBJECT_FLOAT32:
    case MSGPACK_OBJECT_FLOAT64:
        PRINT_JSONSTR_CALL(ret, snprintf, aux_buffer, aux_buffer_size, "%f", o.via.f64);
        break;

    case MSGPACK_OBJECT_STR:
        PRINT_JSONSTR_CALL(ret, snprintf, aux_buffer, aux_buffer_size, "\"");
        PRINT_JSONSTR_CALL(ret, snprintf, aux_buffer, aux_buffer_size, "%.*s", (int)o.via.str.size, o.via.str.ptr);
        PRINT_JSONSTR_CALL(ret, snprintf, aux_buffer, aux_buffer_size, "\"");
        break;

    case MSGPACK_OBJECT_BIN:
        if (bin_contains_zero(&o.via.bin)) {
            DEBUG("the value contains zero\n");
            return -1;
        }
        PRINT_JSONSTR_CALL(ret, snprintf, aux_buffer, aux_buffer_size, "\"");
        PRINT_JSONSTR_CALL(ret, snprintf, aux_buffer, aux_buffer_size, "%.*s", (int)o.via.bin.size, o.via.bin.ptr);
        PRINT_JSONSTR_CALL(ret, snprintf, aux_buffer, aux_buffer_size, "\"");
        break;

    case MSGPACK_OBJECT_EXT:
        DEBUG("not support type: MSGPACK_OBJECT_EXT.\n");
        return -1;

    case MSGPACK_OBJECT_ARRAY:
        PRINT_JSONSTR_CALL(ret, snprintf, aux_buffer, aux_buffer_size, "[");
        if (o.via.array.size != 0) {
            msgpack_object *p = o.via.array.ptr;
            msgpack_object* const pend = o.via.array.ptr + o.via.array.size;
            PRINT_JSONSTR_CALL(ret, msgpack_object_print_jsonstr, aux_buffer, aux_buffer_size, *p);
            ++p;
            for (; p < pend; ++p) {
                PRINT_JSONSTR_CALL(ret, snprintf, aux_buffer, aux_buffer_size, ",");
                PRINT_JSONSTR_CALL(ret, msgpack_object_print_jsonstr, aux_buffer, aux_buffer_size, *p);
            }
        }
        PRINT_JSONSTR_CALL(ret, snprintf, aux_buffer, aux_buffer_size, "]");
        break;

    case MSGPACK_OBJECT_MAP:
        PRINT_JSONSTR_CALL(ret, snprintf, aux_buffer, aux_buffer_size, "{");
        if (o.via.map.size != 0) {
            msgpack_object_kv *p = o.via.map.ptr;
            msgpack_object_kv* const pend = o.via.map.ptr + o.via.map.size;
            
            for (; p < pend; ++p) {
                if (p->key.type != MSGPACK_OBJECT_STR) {
                    DEBUG("the key of in a map must be string.\n");
                    return -1;
                }
                if (p != o.via.map.ptr) {
                    PRINT_JSONSTR_CALL(ret, snprintf, aux_buffer, aux_buffer_size, ",");
                }
                PRINT_JSONSTR_CALL(ret, msgpack_object_print_jsonstr, aux_buffer, aux_buffer_size, p->key);
                PRINT_JSONSTR_CALL(ret, snprintf, aux_buffer, aux_buffer_size, ":");
                PRINT_JSONSTR_CALL(ret, msgpack_object_print_jsonstr, aux_buffer, aux_buffer_size, p->val);
            }
        }
        PRINT_JSONSTR_CALL(ret, snprintf, aux_buffer, aux_buffer_size, "}");
        break;

    default:
        DEBUG("unknown type.\n");
        return -1;
    }

    return (int)length - aux_buffer_size;
}

////////Test Code
char* read_file(const char *filename) {
    FILE *file = NULL;
    long length = 0;
    char *content = NULL;
    size_t read_chars = 0;

    /* open in read binary mode */
    file = fopen(filename, "rb");
    if (file == NULL)
    {
        goto cleanup;
    }

    /* get the length */
    if (fseek(file, 0, SEEK_END) != 0)
    {
        goto cleanup;
    }
    length = ftell(file);
    if (length < 0)
    {
        goto cleanup;
    }
    if (fseek(file, 0, SEEK_SET) != 0)
    {
        goto cleanup;
    }

    /* allocate content buffer */
    content = (char*)malloc((size_t)length + sizeof(""));
    if (content == NULL)
    {
        goto cleanup;
    }

    /* read the file into memory */
    read_chars = fread(content, sizeof(char), (size_t)length, file);
    if ((long)read_chars != length)
    {
        free(content);
        content = NULL;
        goto cleanup;
    }
    content[read_chars] = '\0';


cleanup:
    if (file != NULL)
    {
        fclose(file);
    }

    return content;
}

static void test(const char *inputStr, const char *expectedStr, const char *testName)
{
    msgpack_sbuffer sbuf;
    {
        // pack data into packer
        msgpack_packer pk;
        msgpack_sbuffer_init(&sbuf);
        msgpack_packer_init(&pk, &sbuf, msgpack_sbuffer_write);
        msgpack_pack_jsonstr(&pk, inputStr);
    }

    {
        // unpack data
        msgpack_zone mempool;
        msgpack_object obj;
        int jsonstrlen = (int)strlen(inputStr) + 20;
        char jsonparsed[jsonstrlen];
        
        msgpack_zone_init(&mempool, jsonstrlen);
        msgpack_unpack(sbuf.data, sbuf.size, NULL, &mempool, &obj);
        jsonstrlen = msgpack_object_print_jsonstr(jsonparsed, jsonstrlen, obj);

		printf("-- input--: %s\n",inputStr);
		printf("--output--: %s\n",jsonparsed);
        //compare input and output
        //EXPECT_STREQ
        if (strcmp(expectedStr, jsonparsed) == 0) {
            printf("%s success.\n", testName);
        }else {
            printf("%s failed.\n", testName);
        }

        msgpack_zone_destroy(&mempool);
    }

    msgpack_sbuffer_destroy(&sbuf);
}

void test1(const char *strObj, const char *msgType)
{
    msgpack_sbuffer sbuf;
    {
        // pack data into packer
        msgpack_packer pk;
        msgpack_sbuffer_init(&sbuf);
        msgpack_packer_init(&pk, &sbuf, msgpack_sbuffer_write);
        msgpack_pack_jsonstr(&pk, strObj);
    }

    {
        // unpack data
        msgpack_unpacked result;
        size_t off = 0;
        msgpack_unpack_return ret;
        int i = 0;
        int jsonstrlen = (int)strlen(strObj) + 20;
        char unpacked_buffer[jsonstrlen];
        msgpack_unpacked_init(&result);
        ret = msgpack_unpack_next(&result, strObj, jsonstrlen, &off);
        while (ret == MSGPACK_UNPACK_SUCCESS) {
            msgpack_object obj = result.data;

            /* Use obj. */
            msgpack_object_print_jsonstr(unpacked_buffer,  (int)strlen(strObj), obj);
			printf("-- input--: %s\n", strObj);
			printf("--output--: %s\n", unpacked_buffer);
            //compare input and output
            //EXPECT_STREQ
            if (strcmp(strObj, unpacked_buffer) == 0) {
                printf("%s success.\n", msgType);
            }else {
                printf("%s failed.\n", msgType);
            }

            ret = msgpack_unpack_next(&result, strObj,  (int)strlen(strObj), &off);
        }
        msgpack_unpacked_destroy(&result);
    }

    msgpack_sbuffer_destroy(&sbuf);
}

static void do_test(const char *test_name)
{
    char *expected = NULL;
    char *actual = NULL;

    size_t test_name_length = 0;
    /* path of the test input */
    char *test_path = NULL;
    /* path of the expected output */
    char *expected_path = NULL;

    test_name_length = strlen(test_name);

    /* allocate file paths */
#define TEST_DIR_PATH "inputs/"
    test_path = (char*)malloc(sizeof(TEST_DIR_PATH) + test_name_length);
    expected_path = (char*)malloc(sizeof(TEST_DIR_PATH) + test_name_length + sizeof(".expected"));

    /* create file paths */
    sprintf(test_path, TEST_DIR_PATH"%s", test_name);
    sprintf(expected_path, TEST_DIR_PATH"%s.expected", test_name);

    /* read expected output */
    expected = read_file(expected_path);
    if (expected == NULL || strlen(expected) == 0) {
        goto expectedHandle;
    }
    /* print the parsed tree */
    actual = read_file(test_path);
    if (actual == NULL || strlen(actual) == 0) {
        goto actualHandle;
    }

    test(actual, expected, test_name);

cleanup:
    /* cleanup resources */
    if (expected != NULL)
    {
        free(expected);
    }
    if (actual != NULL)
    {
        free(actual);
    }
    if (test_path != NULL)
    {
        free(test_path);
    }
    if (expected_path != NULL)
    {
        free(expected_path);
    }

    return;

expectedHandle:
    printf("Read Expected File Failed: %s\n", test_name);
    goto cleanup;

actualHandle:
    printf("Read Test File Failed: %s\n", test_name);
    goto cleanup;
}



void testObject()
{
    do_test("test1");
}

void testArray()
{
    do_test("test2");
}

void testMultidimensionalArrays()
{
   do_test("test3");
}

void testObjectsArray()
{
    do_test("test4");
}

void testSimpleString()
{
    char *str = "\"My name is Tom (\\\"Bee\\\") Kobe\"";
    test(str, "My name is Tom (\"Bee\") Kobe", "test_string");

    str = "null";
    test(str, "null", "test_null");

    str = "false";
    test(str, "false", "test_boolean");

    str = "22.33";
    test(str, "22.3300000", "test_number");
}

int main(void)
{
    testObject();
    testArray();
    testMultidimensionalArrays();
    testObjectsArray();
    testSimpleString();
    return 0;
}

