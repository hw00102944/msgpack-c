#include <msgpack/fbuffer.h>
#include <msgpack/zbuffer.h>

#if defined(__GNUC__)
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wconversion"
#endif //defined(__GNUC__)

#include <gtest/gtest.h>

#if defined(__GNUC__)
#pragma GCC diagnostic pop
#endif //defined(__GNUC__)

#include <string.h>

TEST(buffer, zbuffer_c)
{
    msgpack_zbuffer zbuf;
    EXPECT_TRUE(msgpack_zbuffer_init(&zbuf, 1, MSGPACK_ZBUFFER_INIT_SIZE));
    EXPECT_EQ(0, msgpack_zbuffer_write(&zbuf, "a", 1));
    EXPECT_EQ(0, msgpack_zbuffer_write(&zbuf, "a", 1));
    EXPECT_EQ(0, msgpack_zbuffer_write(&zbuf, "a", 1));
    EXPECT_EQ(0, msgpack_zbuffer_write(&zbuf, "", 0));

    EXPECT_TRUE(msgpack_zbuffer_flush(&zbuf) != NULL);

    msgpack_zbuffer_destroy(&zbuf);
}

TEST(buffer, fbuffer_c)
{
#if defined(_MSC_VER)
    FILE* file;
    tmpfile_s(&file);
#else  // defined(_MSC_VER)
    FILE* file = tmpfile();
#endif // defined(_MSC_VER)

    void* fbuf = (void*)file;

    EXPECT_TRUE( file != NULL );
    EXPECT_EQ(0, msgpack_fbuffer_write(fbuf, "a", 1));
    EXPECT_EQ(0, msgpack_fbuffer_write(fbuf, "a", 1));
    EXPECT_EQ(0, msgpack_fbuffer_write(fbuf, "a", 1));

    fflush(file);
    rewind(file);
    for (size_t i=0; i < 3; ++i) {
        int ch = fgetc(file);
        EXPECT_TRUE(ch != EOF);
        EXPECT_EQ('a', (char) ch);
    }
    EXPECT_EQ(EOF, fgetc(file));
    fclose(file);
}
