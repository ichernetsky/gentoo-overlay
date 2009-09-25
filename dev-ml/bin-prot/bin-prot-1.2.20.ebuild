# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="2"

inherit findlib

DESCRIPTION="Automated code generation for converting OCaml values to/from a type-safe binary protocol"
HOMEPAGE="http://www.ocaml.info/home/ocaml_sources.html"
SRC_URI="http://ocaml.info/ocaml_sources/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ia64 ~amd64"
IUSE=""
S=${WORKDIR}/${P}/lib

DEPEND=">=dev-lang/ocaml-3.10
	dev-ml/type-conv
	dev-ml/ounit"
RDEPEND="${DEPEND}"

src_compile() {
	emake -j1 || die
}

src_test() {
	cd "${S}/../lib_test"
	emake -j1 || die "testing failed"
	./mac_test || die
	./test_runner || die
}

src_install() {
	findlib_src_install
	dodoc ../README.txt ../Changelog
}
