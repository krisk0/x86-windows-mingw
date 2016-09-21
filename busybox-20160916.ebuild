# Copyright 2016 Денис Крыськов
# Distributed under the terms of the GNU General Public License v3

EAPI=5

DESCRIPTION="Must-have progs such as sh and rm jammed into singe .exe"
HOMEPAGE=https://github.com/rmyorston/busybox-w32
SHA=977d65c1bbc57f5cdd0c8bfd67c8b5bb1cd390dd
SRC_URI="$HOMEPAGE/archive/$SHA.tar.gz -> $P.tar.gz"
KEYWORDS="-* amd64 x86"

LICENSE=GPL-2
SLOT=windows
RESTRICT=test

d=
( [ .$BITS == .32 ] || use x86 ) && d=cross-i686-w64-mingw32/gcc
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
  ( [ .$BITS == .32 ] || use x86 ) && make mingw32_defconfig
  [ -f .config ] || make mingw64_defconfig
  # realpath does not work, don't bother trying to build it
  # sed -i 's:#.CONFIG_REALPATH.*:CONFIG_REALPATH=y:' .config
 }

# This .ebuild is not meant to be emerge'd. It got to be ebuild'
src_install()
 {
  file $PN.exe
  cp $PN.exe "$ED/"
 }
