#!/bin/bash

MYBINDIR="${PREFIX}/bin"
MYSUFFIXDIR="lib/${PKG_NAME}-${PKG_VERSION}"
MYTARGETDIR="${PREFIX}/${MYSUFFIXDIR}"

mkdir -p "${MYBINDIR}"
mkdir -p "${MYTARGETDIR}"

cp -r ./ "${MYTARGETDIR}/"
cp "${RECIPE_DIR}/cxxtestgen" "${MYBINDIR}/"
