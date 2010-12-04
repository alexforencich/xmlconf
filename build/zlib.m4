
dnl
dnl TRY_ZLIB_LINK(
dnl      test-message, cache-var-name, hdrs, libs,
dnl      [actions-on-success], [actions-on-failure])
dnl         
dnl Tests linking against expat with libraries 'libs' and includes
dnl 'hdrs', passing message + cache-var-name to AC_CACHE_CHECK.
dnl On success, sets $zlib_libs to libs, sets $have_zlib to 1, 
dnl and runs actions-on-success; on failure runs actions-on-failure.
dnl
AC_DEFUN([TRY_ZLIB_LINK], [
AC_CACHE_CHECK([$1], [$2], [
  zlib_LIBS=$LIBS
  LIBS="$LIBS $4"
  AC_TRY_LINK([#include <stdlib.h>
#include <$3>], [deflateInit(NULL, 0);],
    [$2=yes], [$2=no])
  LIBS=$zlib_LIBS
])

if test $[$2] = yes; then
   AC_DEFINE([HAVE_]translit([$3], [a-z./], [A-Z__]), 1,
             [Define if $3 is available])
   zlib_libs="$4"
   has_zlib=1
   $5
else
   has_zlib=0
   $6
fi
])

dnl
dnl SYSTEM_ZLIB: tests for a system zlib installation
dnl If present, sets $has_zlib to 1 and adjusts LDFLAGS/CPPFLAGS
dnl appropriately.  This is mostly for compatibility with existing
dnl zlib releases; all but the first TRY_ZLIB_LINK call could
dnl be dropped later.
dnl
AC_DEFUN([SYSTEM_ZLIB], [
 
  TRY_ZLIB_LINK([Zlib 1.2.x], xc_cv_zlib_system, 
    [zlib.h], [-lz])

dnl  if test $has_expat = 0; then
dnl    TRY_EXPAT_LINK([old Debian-packaged expat], xc_cv_expat_debian,
dnl       [xmltok/xmlparse.h], [-lxmlparse -lxmltok])
dnl  fi

dnl  if test $has_expat = 0; then
dnl    TRY_EXPAT_LINK([old FreeBSD-packaged expat], xc_cv_expat_freebsd,
dnl       [xml/xmlparse.h], [-lexpat])
dnl  fi

dnl  if test $has_expat = 0; then
dnl    TRY_EXPAT_LINK([Expat 1.0/1.1], xc_cv_expat_1011,
dnl       [xmlparse/xmlparse.h], [-lexpat])
dnl  fi

  if test $has_zlib = 0; then
    VAR_ADDTO(LDFLAGS, [-L/usr/local/lib])
    VAR_ADDTO(CPPFLAGS, [-I/usr/local/include])
 
    TRY_ZLIB_LINK([Zlib 1.2.x in /usr/local], 
       xc_cv_zlib_usrlocal, [zlib.h], [-lzlib],
       [VAR_ADDTO(INCLUDES, [-I/usr/local/include])
        VAR_ADDTO(LDFLAGS, [-L/usr/local/lib])],[
       VAR_REMOVEFROM(LDFLAGS, [-L/usr/local/lib])
       VAR_REMOVEFROM(CPPFLAGS, [-I/usr/local/include])
      ])
  fi
])

dnl
dnl FIND_ZLIB: figure out where ZLIB is located (or use bundled)
dnl
AC_DEFUN([FIND_ZLIB], [

save_cppflags="$CPPFLAGS"
save_ldflags="$LDFLAGS"

has_zlib=0

# Default: will use either external or bundled zlib.
try_external_zlib=1
try_builtin_zlib=1

AC_ARG_WITH([zlib],
[  --with-zlib=DIR        specify Zlib location, or 'builtin'], [
  if test "$withval" = "yes"; then
    AC_MSG_ERROR([a directory must be specified for --with-zlib])
  elif test "$withval" = "no"; then
    AC_MSG_ERROR([Expat cannot be disabled (at this time)])
  elif test "$withval" = "builtin"; then
    try_external_zlib=0
  else
    # Add given path to standard search paths if appropriate:
    if test "$withval" != "/usr"; then
      VAR_ADDTO(LDFLAGS, [-L$withval/lib])
      VAR_ADDTO(CPPFLAGS, [-I$withval/include])
      VAR_ADDTO(INCLUDES, [-I$withval/include])
      VAR_ADDTO(LDFLAGS, [-L$withval/lib])
    fi
    # ...and refuse to fall back on the builtin expat.
    try_builtin_zlib=0
  fi
])

if test $try_external_zlib = 1; then
  SYSTEM_ZLIB
fi

if test "${has_zlib}${try_builtin_zlib}" = "01"; then
  dnl This is a bit of a hack.  This only works because we know that
  dnl we are working with the bundled version of the software.
  bundled_subdir="srclib/zlib"
  SUBDIR_CONFIG($bundled_subdir, [--prefix=$prefix --exec-prefix=$exec_prefix --libdir=$libdir --includedir=$includedir])
  VAR_ADDTO(INCLUDES, [-I$top_builddir/$bundled_subdir])
  VAR_ADDTO(LDFLAGS, [-L$top_builddir/$bundled_subdir])
  zlib_libs="$top_builddir/$bundled_subdir/libz.a"
  dnl d="$top_builddir/$bundled_subdir/lib"
  dnl zlib_objs="$d/xmlparse.o $d/xmlrole.o $d/xmltok.o"
fi

VAR_ADDTO(EXPORT_LIBS, [$zlib_libs])
VAR_ADDTO(LIBS, [$zlib_libs])
dnl VAR_ADDTO(ZLIB_OBJS, [$zlib_objs])
dnl AC_SUBST(ZLIB_OBJS)
dnl VAR_ADDTO(LIBS, [$zlib_objs])

ZLIB_DIR=$bundled_subdir
AC_SUBST(ZLIB_DIR)

CPPFLAGS=$save_cppflags
LDFLAGS=$save_ldflags
])


