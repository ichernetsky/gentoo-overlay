# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="3"

inherit multilib eutils

DESCRIPTION="Batteries is just the OCaml development platform"
HOMEPAGE="http://batteries.forge.ocamlcore.org/"
SRC_URI="https://forge.ocamlcore.org/frs/download.php/423/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ia64 ~amd64"
IUSE="+ocamlopt doc"

RDEPEND=">=dev-lang/ocaml-3.11
	ocamlopt? ( >=dev-lang/ocaml-3.11[ocamlopt] )
	=dev-ml/camomile-0.7*
	ocamlopt? ( =dev-ml/camomile-0.7*[ocamlopt] )
	>=dev-ml/findlib-1.2.5"

DEPEND="${RDEPEND}"

src_compile() {
	emake || die "emake all failed"
	if use doc; then
		emake doc || die "emake doc failed"
	fi
}

src_install() {
	DPATH="${D}/$(ocamlfind printconf destdir)"
	mkdir -p "${DPATH}"
	emake OCAMLFIND_DESTDIR="${DPATH}" install || die "emake install failed"
	use doc && (emake DOCROOT="${D}/usr/share/doc/ocaml-batteries" install-doc || die "make install-doc failed")

	dodoc ocamlinit
}
