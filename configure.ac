AC_PREREQ(2.57)

AC_INIT(xmlconf, 0.1.0)

AC_CONFIG_HEADER([config.h])
AC_CONFIG_AUX_DIR(build)

sinclude(build/common.m4)
sinclude(build/expat.m4)

AM_INIT_AUTOMAKE

abs_srcdir=`(cd $srcdir && pwd)`
abs_builddir=`pwd`

top_builddir="$abs_builddir"
AC_SUBST(top_builddir)
AC_SUBST(abs_srcdir)
AC_SUBST(abs_builddir)

dnl Default Paths
prefix=/usr/local
exec_prefix=${prefix}
bindir=${exec_prefix}/bin
sbindir=${exec_prefix}/sbin
libdir=${exec_prefix}/lib
libexecdir=${exec_prefix}/libexec
mandir=${prefix}/man
sysconfdir=${prefix}/etc+
datadir=${prefix}/share+
installbuilddir=${datadir}/build
includedir=${prefix}/include+
localstatedir=${prefix}/var+
runtimedir=${localstatedir}/run

PARSE_ARGUMENTS

AC_PROG_CC
AM_PROG_CC_C_O
AC_PROG_INSTALL

case "${host}" in
        i[[3456789]]86-mingw32*) WIN32="yes" ;;
        *cygwin*) WIN32="yes" ;;
        *) WIN32="no" ;;
esac
AM_CONDITIONAL([WIN32], test "$WIN32" = "yes")

if test "$WIN32" = "yes"; then
	with_expat="builtin"
fi

dnl GTK_REQUIRED_VERSION=2.0.0
dnl GLIB_REQUIRED_VERSION=$GTK_REQUIRED_VERSION

dnl AM_PATH_GLIB_2_0($GLIB_REQUIRED_VERSION,,
dnl  [AC_MSG_ERROR(Test for GLib failed.)], gobject)
dnl AM_PATH_GTK_2_0($GTK_REQUIRED_VERSION,,
dnl   [AC_MSG_ERROR(Test for GTK failed.)])

FIND_EXPAT

AC_CONFIG_FILES([Makefile src/Makefile])
AC_OUTPUT

