
dnl
dnl VAR_SETIFNULL(variable, value)
dnl
dnl  Set variable iff it's currently null
dnl
AC_DEFUN([VAR_SETIFNULL], [
  if test -z "$$1"; then
    test "x$silent" != "xyes" && echo "  setting $1 to \"$2\""
    $1="$2"
  fi
])dnl

dnl
dnl VAR_ADDTO(variable, value)
dnl
dnl  Add value to variable
dnl
AC_DEFUN([VAR_ADDTO], [
  if test "x$$1" = "x"; then
    test "x$silent" != "xyes" && echo "  setting $1 to \"$2\""
    $1="$2"
  else
    addto_bugger="$2"
    for i in $addto_bugger; do
      addto_duplicate="0"
      for j in $$1; do
        if test "x$i" = "x$j"; then
          addto_duplicate="1"
          break
        fi
      done
      if test $addto_duplicate = "0"; then
        test "x$silent" != "xyes" && echo "  adding \"$i\" to $1"
        $1="$$1 $i"
      fi
    done
  fi
])dnl

dnl
dnl VAR_REMOVEFROM(variable, value)
dnl
dnl Remove a value from a variable
dnl
AC_DEFUN([VAR_REMOVEFROM], [
  if test "x$$1" = "x$2"; then
    test "x$silent" != "xyes" && echo "  nulling $1"
    $1=""
  else
    new_bugger=""
    removed=0
    for i in $$1; do
      if test "x$i" != "x$2"; then
        new_bugger="$new_bugger $i"
      else
        removed=1
      fi
    done
    if test $removed = "1"; then
      test "x$silent" != "xyes" && echo "  removed \"$2\" from $1"
      $1=$new_bugger
    fi
  fi
]) dnl

dnl
dnl PARSE_ARGUMENTS
dnl a reimplementation of autoconf's argument parser,
dnl used here to allow us to co-exist layouts and argument based
dnl set ups.
AC_DEFUN([PARSE_ARGUMENTS], [
ac_prev=
# Retrieve the command-line arguments.  The eval is needed because
# the arguments are quoted to preserve accuracy.
eval "set x $ac_configure_args"
shift
for ac_option
do
  # If the previous option needs an argument, assign it.
  if test -n "$ac_prev"; then
    eval "$ac_prev=\$ac_option"
    ac_prev=
    continue
  fi

  ac_optarg=`expr "x$ac_option" : 'x[[^=]]*=\(.*\)'`

  case $ac_option in

  -bindir | --bindir | --bindi | --bind | --bin | --bi)
    ac_prev=bindir ;;
  -bindir=* | --bindir=* | --bindi=* | --bind=* | --bin=* | --bi=*)
    bindir="$ac_optarg" ;;

  -datadir | --datadir | --datadi | --datad | --data | --dat | --da)
    ac_prev=datadir ;;
  -datadir=* | --datadir=* | --datadi=* | --datad=* | --data=* | --dat=* \
  | --da=*)
    datadir="$ac_optarg" ;;

  -exec-prefix | --exec_prefix | --exec-prefix | --exec-prefi \
  | --exec-pref | --exec-pre | --exec-pr | --exec-p | --exec- \
  | --exec | --exe | --ex)
    ac_prev=exec_prefix ;;
  -exec-prefix=* | --exec_prefix=* | --exec-prefix=* | --exec-prefi=* \
  | --exec-pref=* | --exec-pre=* | --exec-pr=* | --exec-p=* | --exec-=* \
  | --exec=* | --exe=* | --ex=*)
    exec_prefix="$ac_optarg" ;;

  -includedir | --includedir | --includedi | --included | --include \
  | --includ | --inclu | --incl | --inc)
    ac_prev=includedir ;;
  -includedir=* | --includedir=* | --includedi=* | --included=* | --include=* \
  | --includ=* | --inclu=* | --incl=* | --inc=*)
    includedir="$ac_optarg" ;;

  -infodir | --infodir | --infodi | --infod | --info | --inf)
    ac_prev=infodir ;;
  -infodir=* | --infodir=* | --infodi=* | --infod=* | --info=* | --inf=*)
    infodir="$ac_optarg" ;;

  -libdir | --libdir | --libdi | --libd)
    ac_prev=libdir ;;
  -libdir=* | --libdir=* | --libdi=* | --libd=*)
    libdir="$ac_optarg" ;;

  -libexecdir | --libexecdir | --libexecdi | --libexecd | --libexec \
  | --libexe | --libex | --libe)
    ac_prev=libexecdir ;;
  -libexecdir=* | --libexecdir=* | --libexecdi=* | --libexecd=* | --libexec=* \
  | --libexe=* | --libex=* | --libe=*)
    libexecdir="$ac_optarg" ;;

  -localstatedir | --localstatedir | --localstatedi | --localstated \
  | --localstate | --localstat | --localsta | --localst \
  | --locals | --local | --loca | --loc | --lo)
    ac_prev=localstatedir ;;
  -localstatedir=* | --localstatedir=* | --localstatedi=* | --localstated=* \
  | --localstate=* | --localstat=* | --localsta=* | --localst=* \
  | --locals=* | --local=* | --loca=* | --loc=* | --lo=*)
    localstatedir="$ac_optarg" ;;

  -mandir | --mandir | --mandi | --mand | --man | --ma | --m)
    ac_prev=mandir ;;
  -mandir=* | --mandir=* | --mandi=* | --mand=* | --man=* | --ma=* | --m=*)
    mandir="$ac_optarg" ;;

  -prefix | --prefix | --prefi | --pref | --pre | --pr | --p)
    ac_prev=prefix ;;
  -prefix=* | --prefix=* | --prefi=* | --pref=* | --pre=* | --pr=* | --p=*)
    prefix="$ac_optarg" ;;

  -sbindir | --sbindir | --sbindi | --sbind | --sbin | --sbi | --sb)
    ac_prev=sbindir ;;
  -sbindir=* | --sbindir=* | --sbindi=* | --sbind=* | --sbin=* \
  | --sbi=* | --sb=*)
    sbindir="$ac_optarg" ;;

  -sharedstatedir | --sharedstatedir | --sharedstatedi \
  | --sharedstated | --sharedstate | --sharedstat | --sharedsta \
  | --sharedst | --shareds | --shared | --share | --shar \
  | --sha | --sh)
    ac_prev=sharedstatedir ;;
  -sharedstatedir=* | --sharedstatedir=* | --sharedstatedi=* \
  | --sharedstated=* | --sharedstate=* | --sharedstat=* | --sharedsta=* \
  | --sharedst=* | --shareds=* | --shared=* | --share=* | --shar=* \
  | --sha=* | --sh=*)
    sharedstatedir="$ac_optarg" ;;

  -sysconfdir | --sysconfdir | --sysconfdi | --sysconfd | --sysconf \
  | --syscon | --sysco | --sysc | --sys | --sy)
    ac_prev=sysconfdir ;;
  -sysconfdir=* | --sysconfdir=* | --sysconfdi=* | --sysconfd=* | --sysconf=* \
  | --syscon=* | --sysco=* | --sysc=* | --sys=* | --sy=*)
    sysconfdir="$ac_optarg" ;;

  esac
done

# Be sure to have absolute paths.
for ac_var in exec_prefix prefix
do
  eval ac_val=$`echo $ac_var`
  case $ac_val in
    [[\\/$]]* | ?:[[\\/]]* | NONE | '' ) ;;
    *)  AC_MSG_ERROR([expected an absolute path for --$ac_var: $ac_val]);;
  esac
done

])dnl

dnl
dnl SUBDIR_CONFIG(dir [, sub-package-cmdline-args, args-to-drop])
dnl
dnl dir: directory to find configure in
dnl sub-package-cmdline-args: arguments to add to the invocation (optional)
dnl args-to-drop: arguments to drop from the invocation (optional)
dnl
dnl Note: This macro relies on ac_configure_args being set properly.
dnl
dnl The args-to-drop argument is shoved into a case statement, so
dnl multiple arguments can be separated with a |.
dnl
dnl Note: Older versions of autoconf do not single-quote args, while 2.54+
dnl places quotes around every argument.  So, if you want to drop the
dnl argument called --enable-layout, you must pass the third argument as:
dnl [--enable-layout=*|\'--enable-layout=*]
dnl
dnl Trying to optimize this is left as an exercise to the reader who wants
dnl to put up with more autoconf craziness.  I give up.
dnl
AC_DEFUN([SUBDIR_CONFIG], [
  # save our work to this point; this allows the sub-package to use it
  AC_CACHE_SAVE

  echo "configuring package in $1 now"
  ac_popdir=`pwd`
  config_subdirs="$1"
  test -d $1 || $mkdir_p $1
  ac_abs_srcdir=`(cd $srcdir/$1 && pwd)`
  cd $1

changequote(, )dnl
      # A "../" for each directory in /$config_subdirs.
      ac_dots=`echo $config_subdirs|sed -e 's%^\./%%' -e 's%[^/]$%&/%' -e 's%[^/]*/%../%g'`
changequote([, ])dnl

  # Make the cache file pathname absolute for the subdirs
  # required to correctly handle subdirs that might actually
  # be symlinks
  case "$cache_file" in
  /*) # already absolute
    ac_sub_cache_file=$cache_file ;;
  *)  # Was relative path.
    ac_sub_cache_file="$ac_popdir/$cache_file" ;;
  esac

  ifelse($3, [], [configure_args=$ac_configure_args],[
  configure_args=
  sep=
  for configure_arg in $ac_configure_args
  do
    case "$configure_arg" in
      $3)
        continue ;;
    esac
    configure_args="$configure_args$sep'$configure_arg'"
    sep=" "
  done
  ])

  dnl autoconf doesn't add --silent to ac_configure_args; explicitly pass it
  test "x$silent" = "xyes" && configure_args="$configure_args --silent"

  dnl AC_CONFIG_SUBDIRS silences option warnings, emulate this for 2.62
  configure_args="--disable-option-checking $configure_args" 

  dnl The eval makes quoting arguments work - specifically the second argument
  dnl where the quoting mechanisms used is "" rather than [].
  dnl
  dnl We need to execute another shell because some autoconf/shell combinations
  dnl will choke after doing repeated SUBDIR_CONFIG()s.  (Namely Solaris
  dnl and autoconf-2.54+)
  if eval $SHELL $ac_abs_srcdir/configure $configure_args --cache-file=$ac_sub_cache_file --srcdir=$ac_abs_srcdir $2
  then :
    echo "$1 configured properly"
  else
    echo "configure failed for $1"
    exit 1
  fi

  cd $ac_popdir

  # grab any updates from the sub-package
  AC_CACHE_LOAD
])dnl

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


