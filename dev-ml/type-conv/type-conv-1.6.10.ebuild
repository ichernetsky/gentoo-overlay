# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="2"

inherit findlib

DESCRIPTION="Mini library required for some other preprocessing libraries"
HOMEPAGE="http://www.ocaml.info/home/ocaml_sources.html"
SRC_URI="http://ocaml.info/ocaml_sources/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ia64 ~amd64"
IUSE=""

DEPEND=">=dev-lang/ocaml-3.10"
RDEPEND="${DEPEND}"

src_install() {
	findlib_src_preinst
	emake install || die "make install failed"
	dodoc README.txt Changelog
}
