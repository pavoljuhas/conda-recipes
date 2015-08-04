#!/bin/bash

export CPATH="$PREFIX/include:$CPATH"

scons -j $CPU_COUNT
scons install prefix=$PREFIX
