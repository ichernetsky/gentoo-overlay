# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="2"

inherit eutils

DESCRIPTION="Batteries is just the OCaml development platform"
HOMEPAGE="http://batteries.forge.ocamlcore.org/"
SRC_URI="https://forge.ocamlcore.org/frs/download.php/366/${P}.tgz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ia64 ~amd64"
IUSE="+ocamlopt doc"

RDEPEND=">=dev-lang/ocaml-3.11
	ocamlopt? ( >=dev-lang/ocaml-3.11[ocamlopt] )
	>=dev-ml/camomile-0.7
	ocamlopt? ( >=dev-ml/camomile-0.7[ocamlopt] )
	>=dev-ml/findlib-1.2.5"

DEPEND="${DEPEND}
	dev-util/omake"

do_omake() {
	local destdir="${D}$(ocamlfind printconf destdir)"
	if use ocamlopt; then
		BATTERIES_NATIVE=true DESTDIR="${destdir}" omake --force-dotomake --dotomake omc $*
	else
		DESTDIR=${destdir} omake --force-dotomake --dotomake omc $*
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-omake.patch"
}

src_compile() {
	sed -i "s:DOCROOT_INSTALL = :DOCROOT_INSTALL = ${D}:g" OMakefile
	do_omake all || die "omake all failed"
	if use doc; then
		do_omake doc || die "omake doc failed"
	fi
}

src_install() {
	mkdir -p "${D}/usr/lib/ocaml/"
	do_omake install || die "omake install failed"
	if use doc; then
		do_omake install-doc || die "omake install-doc failed"
	fi

	dodoc LICENSE
	dodoc README
	dodoc ocamlinit
}
