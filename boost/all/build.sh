#!/bin/bash

# Hints:
# http://boost.2283326.n4.nabble.com/how-to-build-boost-with-bzip2-in-non-standard-location-td2661155.html
# http://www.gentoo.org/proj/en/base/amd64/howtos/?part=1&chap=3
# http://www.boost.org/doc/libs/1_55_0/doc/html/bbv2/reference.html

# Hints for OSX:
# http://stackoverflow.com/questions/20108407/how-do-i-compile-boost-for-os-x-64b-platforms-with-stdlibc

mkdir -vp ${PREFIX}/bin;
MYNCPU=$(( (CPU_COUNT > 4) ? 4 : CPU_COUNT ))

case `uname` in
    Darwin)
        b2_options=( toolset=clang )
        ;;
    Linux)
        b2_options=(
            toolset=gcc
            address-model=${ARCH}
            architecture=x86
            linkflags="'-Wl,-rpath,\$ORIGIN'"
            )
        ;;
esac


./bootstrap.sh \
    --prefix="${PREFIX}/" --libdir="${PREFIX}/lib/" \
    2>&1 | tee bootstrap.log


./b2 -j $MYNCPU \
    variant=release threading=multi link=shared "${b2_options[@]}" \
    install 2>&1 | tee b2.log
