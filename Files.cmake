# .h files
LIST (APPEND msgpackc_HEADERS
    include/msgpack/gcc_atomic.h
    include/msgpack/object.h
    include/msgpack/sysdep.h
    include/msgpack/unpack_define.h
    include/msgpack/version_master.h
    include/msgpack/zone.h
)

# .hpp files
LIST (APPEND msgpackc_HEADERS
    include/msgpack.hpp
    include/msgpack/adaptor/adaptor_base.hpp
    include/msgpack/adaptor/adaptor_base_decl.hpp
    include/msgpack/adaptor/array_ref.hpp
    include/msgpack/adaptor/array_ref_decl.hpp
    include/msgpack/adaptor/bool.hpp
    include/msgpack/adaptor/boost/fusion.hpp
    include/msgpack/adaptor/boost/msgpack_variant.hpp
    include/msgpack/adaptor/boost/msgpack_variant_decl.hpp
    include/msgpack/adaptor/boost/optional.hpp
    include/msgpack/adaptor/boost/string_ref.hpp
    include/msgpack/adaptor/boost/string_view.hpp
    include/msgpack/adaptor/carray.hpp
    include/msgpack/adaptor/char_ptr.hpp
    include/msgpack/adaptor/check_container_size.hpp
    include/msgpack/adaptor/check_container_size_decl.hpp
    include/msgpack/adaptor/cpp11/array.hpp
    include/msgpack/adaptor/cpp11/array_char.hpp
    include/msgpack/adaptor/cpp11/array_unsigned_char.hpp
    include/msgpack/adaptor/cpp11/chrono.hpp
    include/msgpack/adaptor/cpp11/forward_list.hpp
    include/msgpack/adaptor/cpp11/reference_wrapper.hpp
    include/msgpack/adaptor/cpp11/shared_ptr.hpp
    include/msgpack/adaptor/cpp11/timespec.hpp
    include/msgpack/adaptor/cpp11/tuple.hpp
    include/msgpack/adaptor/cpp11/unique_ptr.hpp
    include/msgpack/adaptor/cpp11/unordered_map.hpp
    include/msgpack/adaptor/cpp11/unordered_set.hpp
    include/msgpack/adaptor/cpp17/byte.hpp
    include/msgpack/adaptor/cpp17/carray_byte.hpp
    include/msgpack/adaptor/cpp17/optional.hpp
    include/msgpack/adaptor/cpp17/string_view.hpp
    include/msgpack/adaptor/cpp17/vector_byte.hpp
    include/msgpack/adaptor/define.hpp
    include/msgpack/adaptor/define_decl.hpp
    include/msgpack/adaptor/deque.hpp
    include/msgpack/adaptor/ext.hpp
    include/msgpack/adaptor/ext_decl.hpp
    include/msgpack/adaptor/fixint.hpp
    include/msgpack/adaptor/fixint_decl.hpp
    include/msgpack/adaptor/float.hpp
    include/msgpack/adaptor/int.hpp
    include/msgpack/adaptor/int_decl.hpp
    include/msgpack/adaptor/list.hpp
    include/msgpack/adaptor/map.hpp
    include/msgpack/adaptor/map_decl.hpp
    include/msgpack/adaptor/msgpack_tuple.hpp
    include/msgpack/adaptor/msgpack_tuple_decl.hpp
    include/msgpack/adaptor/nil.hpp
    include/msgpack/adaptor/nil_decl.hpp
    include/msgpack/adaptor/pair.hpp
    include/msgpack/adaptor/raw.hpp
    include/msgpack/adaptor/raw_decl.hpp
    include/msgpack/adaptor/set.hpp
    include/msgpack/adaptor/size_equal_only.hpp
    include/msgpack/adaptor/size_equal_only_decl.hpp
    include/msgpack/adaptor/string.hpp
    include/msgpack/adaptor/tr1/unordered_map.hpp
    include/msgpack/adaptor/tr1/unordered_set.hpp
    include/msgpack/adaptor/v4raw.hpp
    include/msgpack/adaptor/v4raw_decl.hpp
    include/msgpack/adaptor/vector.hpp
    include/msgpack/adaptor/vector_bool.hpp
    include/msgpack/adaptor/vector_char.hpp
    include/msgpack/adaptor/vector_unsigned_char.hpp
    include/msgpack/adaptor/wstring.hpp
    include/msgpack/cpp_config.hpp
    include/msgpack/cpp_config_decl.hpp
    include/msgpack/create_object_visitor.hpp
    include/msgpack/create_object_visitor_decl.hpp
    include/msgpack/fbuffer.hpp
    include/msgpack/fbuffer_decl.hpp
    include/msgpack/gcc_atomic.hpp
    include/msgpack/iterator.hpp
    include/msgpack/iterator_decl.hpp
    include/msgpack/meta.hpp
    include/msgpack/meta_decl.hpp
    include/msgpack/null_visitor.hpp
    include/msgpack/null_visitor_decl.hpp
    include/msgpack/object.hpp
    include/msgpack/object_decl.hpp
    include/msgpack/object_fwd.hpp
    include/msgpack/object_fwd_decl.hpp
    include/msgpack/pack.hpp
    include/msgpack/pack_decl.hpp
    include/msgpack/parse.hpp
    include/msgpack/parse_decl.hpp
    include/msgpack/parse_return.hpp
    include/msgpack/sbuffer.hpp
    include/msgpack/sbuffer_decl.hpp
    include/msgpack/type.hpp
    include/msgpack/unpack.hpp
    include/msgpack/unpack_decl.hpp
    include/msgpack/unpack_exception.hpp
    include/msgpack/v1/adaptor/adaptor_base.hpp
    include/msgpack/v1/adaptor/adaptor_base_decl.hpp
    include/msgpack/v1/adaptor/array_ref.hpp
    include/msgpack/v1/adaptor/array_ref_decl.hpp
    include/msgpack/v1/adaptor/bool.hpp
    include/msgpack/v1/adaptor/boost/fusion.hpp
    include/msgpack/v1/adaptor/boost/msgpack_variant.hpp
    include/msgpack/v1/adaptor/boost/msgpack_variant_decl.hpp
    include/msgpack/v1/adaptor/boost/optional.hpp
    include/msgpack/v1/adaptor/boost/string_ref.hpp
    include/msgpack/v1/adaptor/boost/string_view.hpp
    include/msgpack/v1/adaptor/carray.hpp
    include/msgpack/v1/adaptor/char_ptr.hpp
    include/msgpack/v1/adaptor/check_container_size.hpp
    include/msgpack/v1/adaptor/check_container_size_decl.hpp
    include/msgpack/v1/adaptor/cpp11/array.hpp
    include/msgpack/v1/adaptor/cpp11/array_char.hpp
    include/msgpack/v1/adaptor/cpp11/array_unsigned_char.hpp
    include/msgpack/v1/adaptor/cpp11/chrono.hpp
    include/msgpack/v1/adaptor/cpp11/forward_list.hpp
    include/msgpack/v1/adaptor/cpp11/reference_wrapper.hpp
    include/msgpack/v1/adaptor/cpp11/shared_ptr.hpp
    include/msgpack/v1/adaptor/cpp11/timespec.hpp
    include/msgpack/v1/adaptor/cpp11/tuple.hpp
    include/msgpack/v1/adaptor/cpp11/unique_ptr.hpp
    include/msgpack/v1/adaptor/cpp11/unordered_map.hpp
    include/msgpack/v1/adaptor/cpp11/unordered_set.hpp
    include/msgpack/v1/adaptor/cpp17/byte.hpp
    include/msgpack/v1/adaptor/cpp17/carray_byte.hpp
    include/msgpack/v1/adaptor/cpp17/optional.hpp
    include/msgpack/v1/adaptor/cpp17/string_view.hpp
    include/msgpack/v1/adaptor/cpp17/vector_byte.hpp
    include/msgpack/v1/adaptor/define.hpp
    include/msgpack/v1/adaptor/define_decl.hpp
    include/msgpack/v1/adaptor/deque.hpp
    include/msgpack/v1/adaptor/detail/cpp03_define_array.hpp
    include/msgpack/v1/adaptor/detail/cpp03_define_array_decl.hpp
    include/msgpack/v1/adaptor/detail/cpp03_define_map.hpp
    include/msgpack/v1/adaptor/detail/cpp03_define_map_decl.hpp
    include/msgpack/v1/adaptor/detail/cpp03_msgpack_tuple.hpp
    include/msgpack/v1/adaptor/detail/cpp03_msgpack_tuple_decl.hpp
    include/msgpack/v1/adaptor/detail/cpp11_convert_helper.hpp
    include/msgpack/v1/adaptor/detail/cpp11_define_array.hpp
    include/msgpack/v1/adaptor/detail/cpp11_define_array_decl.hpp
    include/msgpack/v1/adaptor/detail/cpp11_define_map.hpp
    include/msgpack/v1/adaptor/detail/cpp11_define_map_decl.hpp
    include/msgpack/v1/adaptor/detail/cpp11_msgpack_tuple.hpp
    include/msgpack/v1/adaptor/detail/cpp11_msgpack_tuple_decl.hpp
    include/msgpack/v1/adaptor/ext.hpp
    include/msgpack/v1/adaptor/ext_decl.hpp
    include/msgpack/v1/adaptor/fixint.hpp
    include/msgpack/v1/adaptor/fixint_decl.hpp
    include/msgpack/v1/adaptor/float.hpp
    include/msgpack/v1/adaptor/int.hpp
    include/msgpack/v1/adaptor/int_decl.hpp
    include/msgpack/v1/adaptor/list.hpp
    include/msgpack/v1/adaptor/map.hpp
    include/msgpack/v1/adaptor/map_decl.hpp
    include/msgpack/v1/adaptor/msgpack_tuple.hpp
    include/msgpack/v1/adaptor/msgpack_tuple_decl.hpp
    include/msgpack/v1/adaptor/nil.hpp
    include/msgpack/v1/adaptor/nil_decl.hpp
    include/msgpack/v1/adaptor/pair.hpp
    include/msgpack/v1/adaptor/raw.hpp
    include/msgpack/v1/adaptor/raw_decl.hpp
    include/msgpack/v1/adaptor/set.hpp
    include/msgpack/v1/adaptor/size_equal_only.hpp
    include/msgpack/v1/adaptor/size_equal_only_decl.hpp
    include/msgpack/v1/adaptor/string.hpp
    include/msgpack/v1/adaptor/tr1/unordered_map.hpp
    include/msgpack/v1/adaptor/tr1/unordered_set.hpp
    include/msgpack/v1/adaptor/v4raw.hpp
    include/msgpack/v1/adaptor/v4raw_decl.hpp
    include/msgpack/v1/adaptor/vector.hpp
    include/msgpack/v1/adaptor/vector_bool.hpp
    include/msgpack/v1/adaptor/vector_char.hpp
    include/msgpack/v1/adaptor/vector_unsigned_char.hpp
    include/msgpack/v1/adaptor/wstring.hpp
    include/msgpack/v1/cpp_config.hpp
    include/msgpack/v1/cpp_config_decl.hpp
    include/msgpack/v1/detail/cpp03_zone.hpp
    include/msgpack/v1/detail/cpp03_zone_decl.hpp
    include/msgpack/v1/detail/cpp11_zone.hpp
    include/msgpack/v1/detail/cpp11_zone_decl.hpp
    include/msgpack/v1/fbuffer.hpp
    include/msgpack/v1/fbuffer_decl.hpp
    include/msgpack/v1/iterator.hpp
    include/msgpack/v1/iterator_decl.hpp
    include/msgpack/v1/meta.hpp
    include/msgpack/v1/meta_decl.hpp
    include/msgpack/v1/object.hpp
    include/msgpack/v1/object_decl.hpp
    include/msgpack/v1/object_fwd.hpp
    include/msgpack/v1/object_fwd_decl.hpp
    include/msgpack/v1/pack.hpp
    include/msgpack/v1/pack_decl.hpp
    include/msgpack/v1/parse_return.hpp
    include/msgpack/v1/preprocessor.hpp
    include/msgpack/v1/sbuffer.hpp
    include/msgpack/v1/sbuffer_decl.hpp
    include/msgpack/v1/unpack.hpp
    include/msgpack/v1/unpack_decl.hpp
    include/msgpack/v1/unpack_exception.hpp
    include/msgpack/v1/version.hpp
    include/msgpack/v1/versioning.hpp
    include/msgpack/v1/vrefbuffer.hpp
    include/msgpack/v1/vrefbuffer_decl.hpp
    include/msgpack/v1/zbuffer.hpp
    include/msgpack/v1/zbuffer_decl.hpp
    include/msgpack/v1/zone.hpp
    include/msgpack/v1/zone_decl.hpp
    include/msgpack/v2/adaptor/adaptor_base.hpp
    include/msgpack/v2/adaptor/adaptor_base_decl.hpp
    include/msgpack/v2/adaptor/array_ref_decl.hpp
    include/msgpack/v2/adaptor/boost/msgpack_variant_decl.hpp
    include/msgpack/v2/adaptor/check_container_size_decl.hpp
    include/msgpack/v2/adaptor/define_decl.hpp
    include/msgpack/v2/adaptor/detail/cpp03_define_array_decl.hpp
    include/msgpack/v2/adaptor/detail/cpp03_define_map_decl.hpp
    include/msgpack/v2/adaptor/detail/cpp03_msgpack_tuple_decl.hpp
    include/msgpack/v2/adaptor/detail/cpp11_define_array_decl.hpp
    include/msgpack/v2/adaptor/detail/cpp11_define_map_decl.hpp
    include/msgpack/v2/adaptor/detail/cpp11_msgpack_tuple_decl.hpp
    include/msgpack/v2/adaptor/ext_decl.hpp
    include/msgpack/v2/adaptor/fixint_decl.hpp
    include/msgpack/v2/adaptor/int_decl.hpp
    include/msgpack/v2/adaptor/map_decl.hpp
    include/msgpack/v2/adaptor/msgpack_tuple_decl.hpp
    include/msgpack/v2/adaptor/nil_decl.hpp
    include/msgpack/v2/adaptor/raw_decl.hpp
    include/msgpack/v2/adaptor/size_equal_only_decl.hpp
    include/msgpack/v2/adaptor/v4raw_decl.hpp
    include/msgpack/v2/cpp_config_decl.hpp
    include/msgpack/v2/create_object_visitor.hpp
    include/msgpack/v2/create_object_visitor_decl.hpp
    include/msgpack/v2/detail/cpp03_zone_decl.hpp
    include/msgpack/v2/detail/cpp11_zone_decl.hpp
    include/msgpack/v2/fbuffer_decl.hpp
    include/msgpack/v2/iterator_decl.hpp
    include/msgpack/v2/meta_decl.hpp
    include/msgpack/v2/null_visitor.hpp
    include/msgpack/v2/null_visitor_decl.hpp
    include/msgpack/v2/object.hpp
    include/msgpack/v2/object_decl.hpp
    include/msgpack/v2/object_fwd.hpp
    include/msgpack/v2/object_fwd_decl.hpp
    include/msgpack/v2/pack_decl.hpp
    include/msgpack/v2/parse.hpp
    include/msgpack/v2/parse_decl.hpp
    include/msgpack/v2/parse_return.hpp
    include/msgpack/v2/sbuffer_decl.hpp
    include/msgpack/v2/unpack.hpp
    include/msgpack/v2/unpack_decl.hpp
    include/msgpack/v2/vrefbuffer_decl.hpp
    include/msgpack/v2/x3_parse.hpp
    include/msgpack/v2/x3_parse_decl.hpp
    include/msgpack/v2/x3_unpack.hpp
    include/msgpack/v2/x3_unpack_decl.hpp
    include/msgpack/v2/zbuffer_decl.hpp
    include/msgpack/v2/zone_decl.hpp
    include/msgpack/v3/adaptor/adaptor_base.hpp
    include/msgpack/v3/adaptor/adaptor_base_decl.hpp
    include/msgpack/v3/adaptor/array_ref_decl.hpp
    include/msgpack/v3/adaptor/boost/msgpack_variant_decl.hpp
    include/msgpack/v3/adaptor/check_container_size_decl.hpp
    include/msgpack/v3/adaptor/define_decl.hpp
    include/msgpack/v3/adaptor/detail/cpp03_define_array_decl.hpp
    include/msgpack/v3/adaptor/detail/cpp03_define_map_decl.hpp
    include/msgpack/v3/adaptor/detail/cpp03_msgpack_tuple_decl.hpp
    include/msgpack/v3/adaptor/detail/cpp11_define_array_decl.hpp
    include/msgpack/v3/adaptor/detail/cpp11_define_map_decl.hpp
    include/msgpack/v3/adaptor/detail/cpp11_msgpack_tuple_decl.hpp
    include/msgpack/v3/adaptor/ext_decl.hpp
    include/msgpack/v3/adaptor/fixint_decl.hpp
    include/msgpack/v3/adaptor/int_decl.hpp
    include/msgpack/v3/adaptor/map_decl.hpp
    include/msgpack/v3/adaptor/msgpack_tuple_decl.hpp
    include/msgpack/v3/adaptor/nil_decl.hpp
    include/msgpack/v3/adaptor/raw_decl.hpp
    include/msgpack/v3/adaptor/size_equal_only_decl.hpp
    include/msgpack/v3/adaptor/v4raw_decl.hpp
    include/msgpack/v3/cpp_config_decl.hpp
    include/msgpack/v3/create_object_visitor_decl.hpp
    include/msgpack/v3/detail/cpp03_zone_decl.hpp
    include/msgpack/v3/detail/cpp11_zone_decl.hpp
    include/msgpack/v3/fbuffer_decl.hpp
    include/msgpack/v3/iterator_decl.hpp
    include/msgpack/v3/meta_decl.hpp
    include/msgpack/v3/null_visitor_decl.hpp
    include/msgpack/v3/object_decl.hpp
    include/msgpack/v3/object_fwd.hpp
    include/msgpack/v3/object_fwd_decl.hpp
    include/msgpack/v3/pack_decl.hpp
    include/msgpack/v3/parse.hpp
    include/msgpack/v3/parse_decl.hpp
    include/msgpack/v3/parse_return.hpp
    include/msgpack/v3/sbuffer_decl.hpp
    include/msgpack/v3/unpack.hpp
    include/msgpack/v3/unpack_decl.hpp
    include/msgpack/v3/vrefbuffer_decl.hpp
    include/msgpack/v3/x3_parse_decl.hpp
    include/msgpack/v3/x3_unpack.hpp
    include/msgpack/v3/x3_unpack_decl.hpp
    include/msgpack/v3/zbuffer_decl.hpp
    include/msgpack/v3/zone_decl.hpp
    include/msgpack/version.hpp
    include/msgpack/versioning.hpp
    include/msgpack/vrefbuffer.hpp
    include/msgpack/vrefbuffer_decl.hpp
    include/msgpack/x3_parse.hpp
    include/msgpack/x3_parse_decl.hpp
    include/msgpack/x3_unpack.hpp
    include/msgpack/x3_unpack_decl.hpp
    include/msgpack/zbuffer.hpp
    include/msgpack/zbuffer_decl.hpp
    include/msgpack/zone.hpp
    include/msgpack/zone_decl.hpp
)
