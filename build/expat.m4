
dnl
dnl TRY_EXPAT_LINK(
dnl      test-message, cache-var-name, hdrs, libs,
dnl      [actions-on-success], [actions-on-failure])
dnl         
dnl Tests linking against expat with libraries 'libs' and includes
dnl 'hdrs', passing message + cache-var-name to AC_CACHE_CHECK.
dnl On success, sets $expat_libs to libs, sets $apu_have_expat to 1, 
dnl and runs actions-on-success; on failure runs actions-on-failure.
dnl
AC_DEFUN([TRY_EXPAT_LINK], [
AC_CACHE_CHECK([$1], [$2], [
  expat_LIBS=$LIBS
  LIBS="$LIBS $4"
  AC_TRY_LINK([#include <stdlib.h>
#include <$3>], [XML_ParserCreate(NULL);],
    [$2=yes], [$2=no])
  LIBS=$expat_LIBS
])

if test $[$2] = yes; then
   AC_DEFINE([HAVE_]translit([$3], [a-z./], [A-Z__]), 1,
             [Define if $3 is available])
   expat_libs="$4"
   has_expat=1
   $5
else
   has_expat=0
   $6
fi
])

dnl
dnl SYSTEM_EXPAT: tests for a system expat installation
dnl If present, sets $has_expat to 1 and adjusts LDFLAGS/CPPFLAGS
dnl appropriately.  This is mostly for compatibility with existing
dnl expat releases; all but the first TRY_EXPAT_LINK call could
dnl be dropped later.
dnl
AC_DEFUN([SYSTEM_EXPAT], [
 
  TRY_EXPAT_LINK([Expat 1.95.x], xc_cv_expat_system, 
    [expat.h], [-lexpat])

  if test $has_expat = 0; then
    TRY_EXPAT_LINK([old Debian-packaged expat], xc_cv_expat_debian,
       [xmltok/xmlparse.h], [-lxmlparse -lxmltok])
  fi

  if test $has_expat = 0; then
    TRY_EXPAT_LINK([old FreeBSD-packaged expat], xc_cv_expat_freebsd,
       [xml/xmlparse.h], [-lexpat])
  fi

  if test $has_expat = 0; then
    TRY_EXPAT_LINK([Expat 1.0/1.1], xc_cv_expat_1011,
       [xmlparse/xmlparse.h], [-lexpat])
  fi

  if test $has_expat = 0; then
    VAR_ADDTO(LDFLAGS, [-L/usr/local/lib])
    VAR_ADDTO(CPPFLAGS, [-I/usr/local/include])
 
    TRY_EXPAT_LINK([Expat 1.95.x in /usr/local], 
       xc_cv_expat_usrlocal, [expat.h], [-lexpat],
       [VAR_ADDTO(APRUTIL_INCLUDES, [-I/usr/local/include])
        VAR_ADDTO(APRUTIL_LDFLAGS, [-L/usr/local/lib])],[
       VAR_REMOVEFROM(LDFLAGS, [-L/usr/local/lib])
       VAR_REMOVEFROM(CPPFLAGS, [-I/usr/local/include])
      ])
  fi
])

dnl
dnl FIND_EXPAT: figure out where EXPAT is located (or use bundled)
dnl
AC_DEFUN([FIND_EXPAT], [

save_cppflags="$CPPFLAGS"
save_ldflags="$LDFLAGS"

has_expat=0

# Default: will use either external or bundled expat.
try_external_expat=1
try_builtin_expat=1

AC_ARG_WITH([expat],
[  --with-expat=DIR        specify Expat location, or 'builtin'], [
  if test "$withval" = "yes"; then
    AC_MSG_ERROR([a directory must be specified for --with-expat])
  elif test "$withval" = "no"; then
    AC_MSG_ERROR([Expat cannot be disabled (at this time)])
  elif test "$withval" = "builtin"; then
    try_external_expat=0
  else
    # Add given path to standard search paths if appropriate:
    if test "$withval" != "/usr"; then
      VAR_ADDTO(LDFLAGS, [-L$withval/lib])
      VAR_ADDTO(CPPFLAGS, [-I$withval/include])
      VAR_ADDTO(INCLUDES, [-I$withval/include])
      VAR_ADDTO(LDFLAGS, [-L$withval/lib])
    fi
    # ...and refuse to fall back on the builtin expat.
    try_builtin_expat=0
  fi
])

if test $try_external_expat = 1; then
  SYSTEM_EXPAT
fi

if test "${has_expat}${try_builtin_expat}" = "01"; then
  dnl This is a bit of a hack.  This only works because we know that
  dnl we are working with the bundled version of the software.
  bundled_subdir="srclib/expat"
  SUBDIR_CONFIG($bundled_subdir, [--prefix=$prefix --exec-prefix=$exec_prefix --libdir=$libdir --includedir=$includedir --bindir=$bindir])
  VAR_ADDTO(INCLUDES, [-I$top_builddir/$bundled_subdir/lib])
  VAR_ADDTO(LDFLAGS, [-L$top_builddir/$bundled_subdir/lib])
  #expat_libs="$top_builddir/$bundled_subdir/libexpat.la"
  d="$top_builddir/$bundled_subdir/lib"
  expat_objs="$d/xmlparse.o $d/xmlrole.o $d/xmltok.o"
fi

VAR_ADDTO(EXPORT_LIBS, [$expat_libs])
VAR_ADDTO(LIBS, [$expat_libs])
VAR_ADDTO(EXPAT_OBJS, [$expat_objs])
AC_SUBST(EXPAT_OBJS)
VAR_ADDTO(LIBS, [$expat_objs])

XML_DIR=$bundled_subdir
AC_SUBST(XML_DIR)

CPPFLAGS=$save_cppflags
LDFLAGS=$save_ldflags
])


