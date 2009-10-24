# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="2"

DESCRIPTION="Autoconf macros to support configuration of OCaml programs and libraries"
HOMEPAGE="http://ocaml-autoconf.forge.ocamlcore.org/"
SRC_URI="http://forge.ocamlcore.org/frs/download.php/282/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ia64 amd64"
IUSE=""

DEPEND="dev-lang/perl"
RDEPEND=""

src_prepare() {
	sed -i -e "s:/usr/local:/usr:g" ${S}/Makefile
}

src_configure() {
	:
}

src_compile() {
	make || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README
}
