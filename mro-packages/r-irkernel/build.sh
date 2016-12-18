#!/bin/bash
export R_HOME=$PREFIX/lib/R
# R refuses to build packages that mark themselves as Priority: Recommended
mv DESCRIPTION DESCRIPTION.old
grep -v '^Priority: ' DESCRIPTION.old > DESCRIPTION

$R CMD INSTALL --build .

# This installs to the wrong place (/usr/local)
# $R -e "IRkernel::installspec(user=F)"

mkdir -p $PREFIX/share/jupyter/kernels/ir
cp inst/kernelspec/* $PREFIX/share/jupyter/kernels/ir/

# Add more build steps here, if they are necessary.

# See
# http://docs.continuum.io/conda/build.html
# for a list of environment variables that are set during the build process.