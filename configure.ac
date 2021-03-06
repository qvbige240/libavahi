#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])
AC_INIT([libssdp], 1.0, [test])
#AC_CONFIG_SRCDIR([src/avahi-core/server.c])
AC_CONFIG_SRCDIR([config.h.in])
AC_CONFIG_MACRO_DIR([m4])
AC_CONFIG_HEADERS([config.h])
AM_INIT_AUTOMAKE([subdir-objects])

dnl Save the CFLAGS to see whether they were passed in or generated
global_CFLAGS="$CFLAGS"

AC_SUBST(LIBSSDP_VERSION_INFO, [1:0:1])
AC_SUBST(LIBAVAHI_COMMON_VERSION_INFO, [8:3:5])
AC_SUBST(LIBAVAHI_CORE_VERSION_INFO, [7:2:0])

GETTEXT_PACKAGE=avahi
AC_SUBST([GETTEXT_PACKAGE])
AC_DEFINE_UNQUOTED([GETTEXT_PACKAGE],["$GETTEXT_PACKAGE"],[Gettext package])

# Checks for programs.
AC_PROG_CC
AC_PROG_CC_C99
AC_PROG_CXX
AC_PROG_CPP
AC_USE_SYSTEM_EXTENSIONS
AC_PROG_INSTALL
AC_PROG_LN_S
AC_PROG_MAKE_SET
AC_PROG_GCC_TRADITIONAL
AC_PROG_LIBTOOL

# Checks for libraries.
# FIXME: Replace `main' with a function in `-lc':
AC_CHECK_LIB([c], [main])
# FIXME: Replace `main' with a function in `-lgcc':
AC_CHECK_LIB([gcc], [main])
# FIXME: Replace `main' with a function in `-lm':
AC_CHECK_LIB([m], [main])
# FIXME: Replace `main' with a function in `-lpthread':
AC_CHECK_LIB([pthread], [main])

# Checks for header files.
AC_CHECK_HEADERS([arpa/inet.h fcntl.h inttypes.h libintl.h limits.h netinet/in.h stdint.h stdlib.h string.h sys/ioctl.h sys/param.h sys/socket.h sys/time.h unistd.h])

if test x$FINAL_PATH = x; then
    AC_MSG_ERROR([
*** dependency libraries env path missing: export \$FINAL_PATH=    ***
    ])
fi

LIB_PATH='${FINAL_PATH}/lib'
library_dir="$FINAL_PATH/lib"
#top_builddir=.
topsrcdir=$(top_srcdir)
echo "srcdir: $srcdir"
echo "exec_prefix: $exec_prefix"
echo "libdir: $libdir"
echo "topsrcdir: $topsrcdir"
echo "top_builddir: $top_builddir"
echo "library_dir: $library_dir"

echo "======WORKDIR: $WORKDIR "
echo "======DIR_PREMAKE: $DIR_PREMAKE"
echo "========BUILD_PATH: $BUILD_PATH "
echo "========FINAL_PATH: $FINAL_PATH"
echo "========GBASE_INCLUDE: $GBASE_INCLUDE"
echo "========GBASE_LIB: $GBASE_LIB"
echo "========GOLBAL_CFLAGS: $GOLBAL_CFLAGS"
echo "========GOLBAL_CPPFLAGS: $GOLBAL_CPPFLAGS"
echo "========GOLBAL_LDFLAGS: $GOLBAL_LDFLAGS"
echo "========platform: $platform"

INCLUDE="-I$srcdir/include"
if test x$srcdir != x.; then
    INCLUDE="-Iinclude $INCLUDE"
fi

BASE_CFLAGS=""
BASE_LDFLAGS=""

BUILD_CFLAGS="$CFLAGS $CPPFLAGS -DUSING_GENERATED_CONFIG_H"
# The default optimization for ssdp is -O3
if test "x$global_CFLAGS" = x; then
#    BUILD_CFLAGS=`echo $BUILD_CFLAGS | sed 's/-O2/-O3/'`
    BUILD_CFLAGS=`echo $BUILD_CFLAGS | sed 's/-O2/-O0/'`
fi

DESIRED_FLAGS="-std=c99 -Wall -W -Wextra -pedantic -pipe -Wformat -Wold-style-definition -Wdeclaration-after-statement -Wfloat-equal -Wmissing-declarations -Wmissing-prototypes -Wstrict-prototypes -Wredundant-decls -Wmissing-noreturn -Wshadow -Wendif-labels -Wpointer-arith -Wbad-function-cast -Wcast-qual -Wcast-align -Wwrite-strings -fdiagnostics-show-option -Wno-cast-qual -fno-strict-aliasing"
EXTRA_CFLAGS="-Wall -Werror-implicit-function-declaration $DESIRED_FLAGS $BUILD_CFLAGS $INCLUDE $BASE_CFLAGS"
EXTRA_LDFLAGS="$BASE_LDFLAGS"
BUILD_CFLAGS=
BUILD_LDFLAGS=

## sqlite3 config
CheckSqlite3()
{
    AC_ARG_ENABLE(sqlite3,
        AS_HELP_STRING([--disable-sqlite3], [support sqlite3 [[default=no]]]),,
        enable_sqlite3="no")
    if test x$enable_sqlite3 = xyes; then
        AC_DEFINE(HAVE_SQLITE3, 1, [ if sqlite3 is enabled ])
        SQLITE3_CFLAGS="-DUSE_SQLITE3 "
        SQLITE3_LIBS="$LIB_PATH/libsqlite3.a"
        AC_SUBST(SQLITE3_CFLAGS)
        AC_SUBST(SQLITE3_LIBS)
    fi

    #AM_CONDITIONAL(HAVE_SQLITE3, [test x"$enable_sqlite3" = x"yes"])
}

## zlog config
CheckZlog()
{
    AC_ARG_ENABLE(zlog,
        AS_HELP_STRING([--enable-zlog], [support zlog [[default=yes]]]),,
        enable_zlog="yes")
    if test x$enable_zlog = xyes; then
        AC_DEFINE(HAVE_ZLOG, 1, [ if zlog is enabled ])
        BUILD_CFLAGS="$BUILD_CFLAGS -DUSE_ZLOG"
        #ZLOG_LIBS="$LIB_PATH/libzlog.a"
        STATIC_LIBS="$STATIC_LIBS $LIB_PATH/libzlog.a"
    fi
}

## examples config
AC_ARG_ENABLE(examples,
       AS_HELP_STRING([--disable-examples], [Donot build examples during make]),,
       enable_examples="yes")
AM_CONDITIONAL(EXAMPLES, [test "$enable_examples" = "yes"])
AM_CONDITIONAL(ENABLE_TESTS, [test "$enable_examples" = "yes"])

## nmon config
CheckNmon()
{
    AC_ARG_ENABLE(nmon,
        AS_HELP_STRING([--enable-nmon], [support nmon [[default=yes]]]),,
        enable_nmon="yes")
    #if test x$enable_nmon = xyes -a x$enable_alsa = xyes; then
    if test x$enable_nmon = xyes; then
        AC_DEFINE(HAVE_NMON, 1, [ ])
        #NMON_CFLAGS="-g -O3 -Wall -D JFS -DGETUSER -DLARGEMEM -D KERNEL_2_6_18 -D X86"
        NMON_CFLAGS="-D JFS -DGETUSER -DLARGEMEM -D KERNEL_2_6_18 -D X86"
        NMON_LIBS="-lncurses -lm"
        AC_SUBST(NMON_CFLAGS)
        AC_SUBST(NMON_LIBS)
    fi

    #AM_CONDITIONAL(NMON, [test "$enable_nmon" = "yes"])
}

## protobuf-c config
CheckProtoc()
{
    AC_ARG_ENABLE(protoc,
        AS_HELP_STRING([--enable-protoc], [support protoc [[default=yes]]]),,
        enable_protoc="yes")
     
    if test x$enable_protoc = xyes; then
        protobufc=no
        AC_PATH_PROG(PKG_CONFIG, pkg-config, no)
        AC_MSG_CHECKING(for protoc support)
        if test x$PKG_CONFIG != xno; then
            #if $PKG_CONFIG --atleast-pkgconfig-version 0.7 && $PKG_CONFIG --atleast-version 10.0 libprotobuf-c; then
            if $PKG_CONFIG libprotobuf-c; then
                PROTOC_CFLAGS=`$PKG_CONFIG --cflags libprotobuf-c`
                PROTOC_LIBS=`$PKG_CONFIG --libs libprotobuf-c`
                protobufc=yes
            fi
        fi
        AC_MSG_RESULT($protobufc)
    
        if test x$protobufc = xyes; then 
            AC_DEFINE(HAVE_PROTOC, 1, [ ])

            EXTRA_CFLAGS="$EXTRA_CFLAGS $PROTOC_CFLAGS"
            EXTRA_LDFLAGS="$EXTRA_LDFLAGS $PROTOC_LIBS"
        else
            #echo "-- dynamic libwayland-client -> $wayland_client_lib"
            #echo "-- protobuf-c missing"
            AC_MSG_ERROR([
            *** libprotobuf-c missing!
            ])
        fi
    fi
}

CheckZlog
#CheckNmon
#CheckProtoc
#CheckSqlite3
#echo "sqlite lib: $SQLITE3_LIBS"

if test x$platform = xnt966x; then
    AC_DEFINE(MIPS_NT966X, 1, [nt966x])
    PF_TARGET="MIPS_NT966X"
    echo "nt966x compile"

    DYNAMIC_LIBS="-lc"
elif test x$platform = xx86; then
    AC_DEFINE(X86, 1, [x86])
    PF_TARGET="X86"
    echo "x86 compile"
    DYNAMIC_LIBS="-lc"
elif test x$platform = xubuntu; then
    AC_DEFINE(X86_UBUNTU, 1, [ubuntu])
    PF_TARGET="X86_UBUNTU"
    echo "ubuntu compile"
    DYNAMIC_LIBS="-lc"
elif test x$platform = xcentos; then
    AC_DEFINE(X86_CENTOS, 1, [centos])
    PF_TARGET="X86_CENTOS"
    echo "centos compile"
    DYNAMIC_LIBS="-lc"
else
    echo "=========  unknown platform  ========"
fi

DYNAMIC_LIBS="$DYNAMIC_LIBS -lpthread -lrt -lm"

LIBEVENT_LIB="$LIB_PATH/libevent.a $LIB_PATH/libevent_pthreads.a"
JANSSON_LIB="$LIB_PATH/libjansson.a"
LIBVPK_LIB="$LIB_PATH/libvpk.a"
STATIC_LIBS="$STATIC_LIBS $LIBVPK_LIB $LIBEVENT_LIB $JANSSON_LIB"

echo "STATIC_LIBS: $STATIC_LIBS"
AC_SUBST(STATIC_LIBS)
AC_SUBST(DYNAMIC_LIBS)

SSDP_CFLAGS="$BASE_CFLAGS"
SSDP_LIBS="-lssdp $BASE_LDFLAGS"
SSDP_LDFLAGS='$(top_builddir)/src/.libs'

# -std=gnu99 -D_GNU_SOURCE -D_XOPEN_SOURCE=500
EXTRA_CFLAGS="-fPIC $EXTRA_CFLAGS -DDEBUG -DHAVE_VPK $BUILD_CFLAGS ${GOLBAL_CFLAGS} "
EXTRA_LDFLAGS="$EXTRA_LDFLAGS ${GOLBAL_LDFLAGS}"
echo "EXTRA_CFLAGS: $EXTRA_CFLAGS"
echo "EXTRA_LDFLAGS: $EXTRA_LDFLAGS"

CPPFLAGS="$CPPFLAGS $EXTRA_CPPFLAGS"
CFLAGS="$EXTRA_CFLAGS"
LDFLAGS="$LDFLAGS $EXTRA_LDFLAGS"

echo "CFLAGS: $CFLAGS"
echo "LDFLAGS: $LDFLAGS"

echo "platform: $PF_TARGET"
echo "platform11111: ${PF_TARGET}"
echo 'platform22222: $(PF_TARGET)'
AM_CONDITIONAL(X86, test x$PF_TARGET = xX86)
AM_CONDITIONAL(X86_UBUNTU, test x$PF_TARGET = xX86_UBUNTU)
AM_CONDITIONAL(X86_CENTOS, test x$PF_TARGET = xX86_CENTOS)
AM_CONDITIONAL(MIPS_NT966X, test x${PF_TARGET} = xMIPS_NT966X)

#
# Check for netlink.h
#
AC_CHECK_HEADER(linux/netlink.h,
HAVE_NETLINK=yes
AC_DEFINE([HAVE_NETLINK],[],[Support for Linux netlink])
, [], [
#include <sys/socket.h>
#include <asm/types.h>
])

AM_CONDITIONAL(HAVE_NETLINK, [ test x"$HAVE_NETLINK" = xyes ])

#
# Check for net/route.h
#
AC_CHECK_HEADER(net/route.h,
HAVE_PF_ROUTE=yes
AC_DEFINE([HAVE_PF_ROUTE],[],[Support for PF_ROUTE])
, [], [
#include <sys/types.h>
#include <sys/socket.h>
#include <net/if_dl.h>
])

AM_CONDITIONAL(HAVE_PF_ROUTE, [ test x"$HAVE_PF_ROUTE" = xyes ])
AM_CONDITIONAL(HAVE_DBUS, test "x$HAVE_DBUS" = "xyes")


# Checks for typedefs, structures, and compiler characteristics.
AC_C_INLINE
AC_TYPE_INT64_T
AC_TYPE_SIZE_T
AC_TYPE_SSIZE_T
AC_TYPE_UINT16_T
AC_TYPE_UINT32_T
AC_TYPE_UINT8_T
AC_TYPE_PID_T

# Checks for library functions.
AC_FUNC_ERROR_AT_LINE
AC_FUNC_FORK
AC_FUNC_GETMNTENT
AC_FUNC_MALLOC
AC_FUNC_REALLOC
AC_CHECK_FUNCS([gethostname gettimeofday memchr memset select socket strcasecmp strchr strcspn strerror strncasecmp strrchr strspn strstr uname])

AC_CONFIG_FILES([Makefile
                 src/Makefile
                 src/avahi-common/Makefile
                 src/avahi-core/Makefile
                 src/examples/Makefile])
AC_OUTPUT
