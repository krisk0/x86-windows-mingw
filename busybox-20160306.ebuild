# Copyright 2016 Денис Крыськов

EAPI=5

DESCRIPTION="Must-have progs such as bash and rm jammed into singe .exe"
HOMEPAGE=https://github.com/pclouds/busybox-w32
SHA=2762242f30d0d046a80abe41fd78415052bbe95f
SRC_URI="$HOMEPAGE/archive/$SHA.tar.gz -> $P.tar.gz"
KEYWORDS="-* amd64 x86"

LICENSE=GPL-2
SLOT=windows
RESTRICT=test

d=
( use x86 || BITS=32 ) && d=cross-i686-w64-mingw32/gcc
[ -z $d ] && d=cross-x86_64-w64-mingw32/gcc
DEPEND=" $(echo $d) "

QA_PRESTRIPPED=".*\.exe"

src_unpack()
 {
  default
  mv busybox-* $P
 }

src_configure()
 {
  ( use x86 || BITS=32 ) && make mingw32_defconfig
  [ -f .config ] || make mingw64_defconfig
 }

# This .ebuild is not meant to be emerge'd. It got to be ebuild'
src_install()
 {
  file $PN.exe
  cp $PN.exe "$ED/"
 }
