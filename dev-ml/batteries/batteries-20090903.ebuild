# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="2"

inherit findlib

DESCRIPTION="OCaml Batteries included is a consistent, documented, and comprehensive development platform for the OCaml"
HOMEPAGE="http://batteries.forge.ocamlcore.org/"
SRC_URI="http://forge.ocamlcore.org/frs/download.php/256/${P}.tgz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ia64 ~amd64"
IUSE="+ocamlopt"

DEPEND=">=dev-lang/ocaml-3.11
	ocamlopt? ( >=dev-lang/ocaml-3.11[ocamlopt] )
	dev-ml/type-conv
	>=dev-ml/sexplib-3.7.5
	dev-ml/bin-prot
	>=dev-ml/camomile-0.7
	dev-ml/camlzip
	>=dev-ml/ocamlnet-2.2.9"
RDEPEND="${DEPEND}"

src_configure() {
	./configure || die "configure failed"
}

src_compile() {
	make -j1 || die "make failed"
	if use ocamlopt; then
		make -j1 opt || die "make opt failed"
	fi
}

src_install() {
	findlib_src_preinst
	make DESTDIR="${OCAMLFIND_DESTDIR}" install || die "make failed"
	dodoc README ChangeLog
}
