#! /bin/bash

libtoolize
aclocal
autoheader
autoconf
automake --add-missing


 ######################## x86 ########################
 export FINAL_PATH=/home/zouqing/work/carnet/linux/auto/premake/x86/install
 export FINAL_PATH=$PWD/install
 export GOLBAL_CFLAGS="-I/usr/include -I$FINAL_PATH/include"
 export GOLBAL_CPPFLAGS="-I/usr/include -I$FINAL_PATH/include"
 export GOLBAL_LDFLAGS="-L/usr/lib -L$FINAL_PATH/lib"
 export platform=ubuntu

# ../configure --prefix=$PWD/../install --enable-examples

