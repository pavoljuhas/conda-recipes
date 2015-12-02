#!/bin/bash

export CPATH="$PREFIX/include:$CPATH"
export LIBRARY_PATH="$PREFIX/lib:$LIBRARY_PATH"
MYNCPU=$(( (CPU_COUNT > 8) ? 8 : CPU_COUNT ))

if [ `uname` == Darwin ]; then
    export DYLD_FALLBACK_LIBRARY_PATH="$PREFIX/lib:$DYLD_FALLBACK_LIBRARY_PATH"
fi

scons -j $MYNCPU install prefix=$PREFIX

# Add more build steps here, if they are necessary.

$PYTHON setup.py --version > __conda_version__.txt

# See
# http://docs.continuum.io/conda/build.html
# for a list of environment variables that are set during the build process.
