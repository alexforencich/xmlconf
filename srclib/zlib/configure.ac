dnl Process this with autoconf to create configure

AC_PREREQ(2.64)
AC_INIT
AC_CONFIG_SRCDIR([zlib.h])

AC_CONFIG_MACRO_DIR([m4])

#AC_CANONICAL_SYSTEM

AM_INIT_AUTOMAKE(zlib, 1.2.5)

AM_MAINTAINER_MODE

# The same as in boehm-gc and libstdc++. Have to borrow it from there.
# We must force CC to /not/ be precious variables; otherwise
# the wrong, non-multilib-adjusted value will be used in multilibs.
# As a side effect, we have to subst CFLAGS ourselves.

m4_rename([_AC_ARG_VAR_PRECIOUS],[real_PRECIOUS])
m4_define([_AC_ARG_VAR_PRECIOUS],[])
AC_PROG_CC
m4_rename_force([real_PRECIOUS],[_AC_ARG_VAR_PRECIOUS])

AC_SUBST(CFLAGS)

AC_PROG_LIBTOOL

# Find CPP now so that any conditional tests below won't do it and
# thereby make the resulting definitions conditional.
AC_PROG_CPP

   AC_FUNC_MMAP
   AC_CHECK_FUNCS(memcpy strerror)

AC_SUBST(target_all)

AC_CHECK_HEADERS(unistd.h)

  toolexecdir='$(libdir)/gcc-lib/$(target_alias)'
  toolexeclibdir='$(libdir)'

if test "$GCC" = yes && $CC -print-multi-os-directory > /dev/null 2>&1; then
  multiosdir=/`$CC -print-multi-os-directory`
  case $multiosdir in
    /.) multiosdir= ;; # Avoid trailing /.
  esac
else
  multiosdir=
fi
toolexeclibdir=${toolexeclibdir}${multiosdir}
AC_SUBST(toolexecdir)
AC_SUBST(toolexeclibdir)

AM_CONDITIONAL(TARGET_LIBRARY, test -n "$with_target_subdir")

AC_CONFIG_FILES([Makefile])
AC_OUTPUT

