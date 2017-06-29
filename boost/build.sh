#!/bin/bash

# Hints:
# http://boost.2283326.n4.nabble.com/how-to-build-boost-with-bzip2-in-non-standard-location-td2661155.html
# http://www.gentoo.org/proj/en/base/amd64/howtos/?part=1&chap=3
# http://www.boost.org/doc/libs/1_55_0/doc/html/bbv2/reference.html

# Hints for OSX:
# http://stackoverflow.com/questions/20108407/how-do-i-compile-boost-for-os-x-64b-platforms-with-stdlibc

set -x -e
set -o pipefail

# Require MACOSX_DEPLOYMENT_TARGET <= 10.8 to make sure the
# macosx-serialization-no-hiding.patch is relevant.
if [[ "$(uname)" == Darwin ]]; then
    case "${MACOSX_DEPLOYMENT_TARGET}" in
	10.[678])
	    : "OK, do nothing."
	    ;;
	*)
	    t="$MACOSX_DEPLOYMENT_TARGET"
	    echo "Expected MACOSX_DEPLOYMENT_TARGET <= 10.8, got '$t'." >&2
	    echo "macosx-serialization-no-hiding.patch may be unnecessary." >&2
	    exit 2
	    ;;
    esac
fi


case `uname` in
    Darwin)
        b2_options=( toolset=clang )
        ;;
    Linux)
        b2_options=( toolset=gcc )
        ;;
esac

# Use python-config or python3-config to determine Python headers path.
MY_PYTHON_CONFIG="${PREFIX}/bin/python-config"
if [[ ${PY3K} == 1 ]]; then
    MY_PYTHON_CONFIG="${PREFIX}/bin/python3-config"
fi
MY_PYTHON_INCLUDES="$( "${MY_PYTHON_CONFIG}" --includes | sed s/-I//g )"

./bootstrap.sh \
    --prefix="${PREFIX}" \
    --with-icu="${PREFIX}" \
    --with-python="${PYTHON}" \
    --with-python-root="${PREFIX} : ${MY_PYTHON_INCLUDES}" \
    2>&1 | tee bootstrap.log

./b2 -q -j ${CPU_COUNT} \
    variant=release \
    address-model=${ARCH} \
    architecture=x86 \
    threading=multi \
    link=static,shared \
    "${b2_options[@]}" \
    install 2>&1 | tee b2.log
