# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="2"

inherit findlib eutils

DESCRIPTION="Batteries is just the OCaml development platform"
HOMEPAGE="http://batteries.forge.ocamlcore.org/"
SRC_URI="https://forge.ocamlcore.org/frs/download.php/346/${P}.tgz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ia64 ~amd64"
IUSE="doc"

RDEPEND=">=dev-lang/ocaml-3.11[ocamlopt]
	>=dev-ml/camomile-0.7[ocamlopt]"

DEPEND="${DEPEND}
	dev-util/omake"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-omake.patch"
}

src_compile() {
	sed -i "s:DESTDIR_PREFIX = :DESTDIR_PREFIX = ${D}:g" OMakefile
	sed -i "s:DOCROOT_INSTALL = :DOCROOT_INSTALL = ${D}:g" OMakefile
	omake --force-dotomake --dotomake omc all || die "omake all failed"
	if use doc; then
		omake --force-dotomake --dotomake omc doc || die "omake doc failed"
	fi
}

src_install() {
	mkdir -p "${D}/usr/lib/ocaml/"
	omake --force-dotomake --dotomake omc install || die "omake install failed"
	if use doc; then
		omake --force-dotomake --dotomake omc install-doc || die "omake install-doc failed"
	fi

	dodoc LICENSE
	dodoc README
	dodoc ocamlinit
}
