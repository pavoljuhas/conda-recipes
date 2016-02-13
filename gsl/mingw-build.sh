#!/bin/bash

case $ARCH in
    32)
        export CC=/usr/bin/i686-w64-mingw32-gcc ;;
    64)
        export CC=/usr/bin/x86_64-w64-mingw32-gcc ;;
    *)
        echo "Invalid value of ARCH=$ARCH" >&2
        exit 2
        ;;
esac

./configure --prefix="${CYGWIN_PREFIX}/Library" --with-pic

/usr/bin/make -j ${CPU_COUNT}
/usr/bin/make check
/usr/bin/make install-strip
