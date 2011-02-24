# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="3"

inherit multilib eutils git

DESCRIPTION="Batteries is just the OCaml development platform"
HOMEPAGE="http://batteries.forge.ocamlcore.org/"

EGIT_BRANCH="master"
EGIT_REPO_URI="git://github.com/ocaml-batteries-team/batteries-included.git"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ia64 ~amd64"
IUSE="+ocamlopt doc"

RDEPEND=">=dev-lang/ocaml-3.11
	ocamlopt? ( >=dev-lang/ocaml-3.11[ocamlopt] )
	>=dev-ml/camomile-0.8
	ocamlopt? ( >=dev-ml/camomile-0.8[ocamlopt] )
	>=dev-ml/findlib-1.2.5"

DEPEND="${RDEPEND}"

src_compile() {
	emake camomile82 || die "emake camomile82 failed"
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
