`msgpack` for C/C++
===================

Version 3.2.1 [![Build Status](https://travis-ci.org/msgpack/msgpack-c.svg?branch=master)](https://travis-ci.org/msgpack/msgpack-c) [![Build status](https://ci.appveyor.com/api/projects/status/8kstcgt79qj123mw/branch/master?svg=true)](https://ci.appveyor.com/project/redboltz/msgpack-c/branch/master)
[![codecov](https://codecov.io/gh/msgpack/msgpack-c/branch/master/graph/badge.svg)](https://codecov.io/gh/msgpack/msgpack-c)

It's like JSON but smaller and faster.

Overview
--------

[MessagePack](http://msgpack.org/) is an efficient binary serialization
format, which lets you exchange data among multiple languages like JSON,
except that it's faster and smaller. Small integers are encoded into a
single byte and short strings require only one extra byte in
addition to the strings themselves.

Example
-------

In C:

```c
#include <msgpack.h>
#include <stdio.h>

int main(void)
{
    /* msgpack::sbuffer is a simple buffer implementation. */
    msgpack_sbuffer sbuf;
    msgpack_sbuffer_init(&sbuf);

    /* serialize values into the buffer using msgpack_sbuffer_write callback function. */
    msgpack_packer pk;
    msgpack_packer_init(&pk, &sbuf, msgpack_sbuffer_write);

    msgpack_pack_array(&pk, 3);
    msgpack_pack_int(&pk, 1);
    msgpack_pack_true(&pk);
    msgpack_pack_str(&pk, 7);
    msgpack_pack_str_body(&pk, "example", 7);

    /* deserialize the buffer into msgpack_object instance. */
    /* deserialized object is valid during the msgpack_zone instance alive. */
    msgpack_zone mempool;
    msgpack_zone_init(&mempool, 2048);

    msgpack_object deserialized;
    msgpack_unpack(sbuf.data, sbuf.size, NULL, &mempool, &deserialized);

    /* print the deserialized object. */
    msgpack_object_print(stdout, deserialized);
    puts("");

    msgpack_zone_destroy(&mempool);
    msgpack_sbuffer_destroy(&sbuf);

    return 0;
}
```

See [`QUICKSTART-C.md`](./QUICKSTART-C.md) for more details.

### Building and Installing

#### Install from git repository

##### Using the Terminal (CLI)

You will need:

 - `gcc >= 4.1.0`
 - `cmake >= 2.8.0`

C:

    $ git clone https://github.com/msgpack/msgpack-c.git
    $ cd msgpack-c
    $ cmake .
    $ make
    $ sudo make install

When you use the C part of `msgpack-c`, you need to build and link the library. By default, both static/shared libraries are built. If you want to build only static library, set `BUILD_SHARED_LIBS=OFF` to cmake. If you want to build only shared library, set `BUILD_SHARED_LIBS=ON`.

#### GUI on Windows

Clone msgpack-c git repository.

    $ git clone https://github.com/msgpack/msgpack-c.git

or using GUI git client.

e.g.) tortoise git https://code.google.com/p/tortoisegit/

1. Launch [cmake GUI client](http://www.cmake.org/cmake/resources/software.html).

2. Set 'Where is the source code:' text box and 'Where to build
the binaries:' text box.

3. Click 'Configure' button.

4. Choose your Visual Studio version.

5. Click 'Generate' button.

6. Open the created msgpack.sln on Visual Studio.

7. Build all.


