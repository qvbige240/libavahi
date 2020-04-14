#! /bin/bash

libtoolize
aclocal
autoheader
autoconf
automake --add-missing

# ../configure --prefix=$PWD/../install --enable-examples

