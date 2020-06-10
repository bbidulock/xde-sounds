#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])
AC_INIT([xde-sounds],[1.1],[https://github.com/bbidulock/xde-sounds],[xde-sounds])
AC_REVISION([1.1])

# set better defaults
AC_PREFIX_DEFAULT([/usr])
if test "$prefix" = /usr -o "$prefix" = NONE; then
	test "$sysconfdir" = '${prefix}/etc' && sysconfdir=/etc
	test "$sharedstatedir" = '${prefix}/com' && sharedstatedir=/var
	test "$localstatedir" = '${prefix}/var' && localstatedir=/var
fi

AC_CONFIG_SRCDIR([configure.ac])
AC_CONFIG_MACRO_DIR([m4])
AC_CONFIG_AUX_DIR([scripts])

DATE='2020-05-10'
AC_SUBST([DATE])

MDOCDATE='May 10, 2020'
AC_SUBST([MDOCDATE])

BRANCH='1.1'
AC_SUBST([BRANCH])

# Initialize Automake
AM_INIT_AUTOMAKE([gnits 1.16 dist-lzip no-dist-gzip std-options -Wall color-tests silent-rules tar-pax])
AM_MAINTAINER_MODE
AM_SILENT_RULES([yes])

# Checks for programs.
AC_PROG_SED
AC_PROG_AWK
AC_PROG_INSTALL
AC_PROG_LN_S
AC_PROG_MAKE_SET
AC_PROG_MKDIR_P

AC_ARG_VAR([FLITE],[flite command. @<:@default=flite@:>@])
AC_CHECK_PROGS([FLITE],[flite flite2],[],[$PATH])
if test -z "$FLITE" ; then
	AC_MSG_ERROR([
*** 
*** Need the flite program to generate speech synthesis samples.  Please
*** specify the location of the flite binary with the FLITE variable to
*** ./configure before running again.
*** ])
fi

AC_ARG_VAR([FLITEDIR],[flite voice directory. @<:@default=/usr/lib/flite@:>@])
AC_MSG_CHECKING([for flite voice directory])
if test -z "$FLITEDIR"; then
	FLITEDIR=/usr/lib/flite
fi
if test -d "$FLITEDIR" ; then
	AC_MSG_RESULT([$FLITEDIR])
else
	AC_MSG_RESULT([no])
	AC_MSG_ERROR([
*** 
*** Need to know the directory where flitevox voices are stored.
*** Please specify the directory with the FLITEDIR variable to
*** ./configure before running again.
*** ])
fi

AC_ARG_VAR([SOX],[sox audio processing command. @<:@default=sox@:>@])
AC_CHECK_PROGS([SOX],[sox],[],[$PATH])
AM_CONDITIONAL([HAVE_SOX],[test -n "$SOX"])
if test -z "$SOX" ; then
	AC_MSG_WARN([
*** 
*** Need the sox program to apply effects to and normalize synthesized
*** voice.  Please consider specifying the location of the sox binary
*** with the SOX variable to ./configure before running again.
*** ])
	enable_effects=no
fi

AC_ARG_VAR([MARKDOWN],[markdown command. @<:@default=markdown@:>@])
AC_CHECK_PROGS([MARKDOWN],[markdown],[${am_missing_run}markdown],[$PATH])

AC_ARG_VAR([ASCIIDOC],[asciidoc command. @<:@default=asciidoctor@:>@])
AC_CHECK_PROGS([ASCIIDOC],[asciidoc asciidoctor],[${am_missing_run}asciidoc],[$PATH])

AC_ARG_VAR([ASCIIDOC_BACKEND],[asciidoc backend @<:@default=NONE@:>@])
if test -z "$ASCIIDOC_BACKEND"; then
	case "$ASCIIDOC" in
		asciidoc) ASCIIDOC_BACKEND="--backend=html4" ;;
		asciidoctor) ASCIIDOC_BACKEND="--backend=html5" ;;
		*) AC_MSG_WARN([ASCIIDOC $ASCIIDOC is not supported.]) ;;
	esac
fi

AC_ARG_VAR([ASCIIMAN],[asciidoc to manpage converter. @<:@default=a2x@:>@])
AC_CHECK_PROGS([ASCIIMAN],[a2x asciidoctor],[${am_missing_run}a2x],[$PATH])

AC_ARG_VAR([ASCIIMAN_FORMAT],[asciidoc manpage option @<:@default=NONE@:>@])
if test -z "$ASCIIMAN_FORMAT"; then
	case "$ASCIIMAN" in
		a2x) ASCIIMAN_FORMAT="--format=manpage" ;;
		asciidoctor) ASCIIMAN_FORMAT="--backend=manpage" ;;
		*) AC_MSG_WARN([ASCIIMAN $ASCIIMAN is not supported.]) ;;
	esac
fi

AC_ARG_VAR([LINKS],[links command. @<:@default=lynx@:>@])
AC_CHECK_PROGS([LINKS],[lynx links],[${am_missing_run}lynx],[$PATH])
if test "$LINKS" = "links"; then
	LINKS="links -codepage utf-8"
fi

AC_ARG_ENABLE([effects],
	AC_HELP_STRING([--disable-effects],
		[Enable sox effects on output files @<:@default=enabled@:>@]))
AM_CONDITIONAL([EFFECTS],[test x${enable_effects:-yes} = xyes])
AC_MSG_CHECKING([for effects])
AC_MSG_RESULT([${enable_effects:-yes}])

AC_ARG_WITH([male-voice],
	AC_HELP_STRING([--with-male-voice],
		[Specify the default male voice @<:@default=cmu_us_rms@:>@]))
AC_MSG_CHECKING([for M voice])
if test -z "$with_male_voice" ; then
	MVOICE=cmu_us_rms
else
	MVOICE=$(basename "$with_male_voice" .flitevox)
fi
if test -f "${FLITEDIR}/${MVOICE}.flitevox" ; then
	AC_MSG_RESULT([$MVOICE])
else
	AC_MSG_RESULT([no])
	AC_MSG_ERROR([Male voice ${FLITEDIR}/${MVOICE}.flitevox not available.])
fi
AC_SUBST([MVOICE])

AC_ARG_WITH([female-voice],
	AC_HELP_STRING([--with-female-voice],
		[Specify the default female voice @<:@default=cmu_us_slt@:>@]))
AC_MSG_CHECKING([for F voice])
if test -z "$with_female_voice" ; then
	FVOICE=cmu_us_slt
else
	FVOICE=$(basename "$with_female_voice" .flitevox)
fi
if test -f "${FLITEDIR}/${FVOICE}.flitevox" ; then
	AC_MSG_RESULT([$FVOICE])
else
	AC_MSG_RESULT([no])
	AC_MSG_ERROR([Female voice ${FLITEDIR}/${FVOICE}.flitevox not available.])
fi
AC_SUBST([FVOICE])

test "x$prefix" = xNONE && prefix="$ac_default_prefix"
sharedir="$datadir"
eval "sharedir=\"$sharedir\""
eval "sharedir=\"$sharedir\""
eval "sharedir=\"$sharedir\""

AC_SUBST([sharedir])

soundsdir='$(datadir)/sounds'
AC_SUBST([soundsdir])

AC_CONFIG_FILES([Makefile
		 man/Makefile
		 src/Makefile])
AC_OUTPUT

# vim: set ft=config:
