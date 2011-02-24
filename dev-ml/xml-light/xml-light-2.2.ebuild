# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="2"

inherit findlib

S=${WORKDIR}/${PN}

DESCRIPTION="Minimal Xml parser and printer for OCaml"
HOMEPAGE="http://tech.motion-twin.com/xmllight.html"
SRC_URI="http://tech.motion-twin.com/zip/${P}.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="dev-lang/ocaml"

destdir=${D}`ocamlfind printconf destdir`/${PN}

src_prepare() {
	sed -i -e "s:\`ocamlc -where\`:${destdir}:g" ${S}/Makefile
}

src_compile() {
	make || make || die "make failed"
	make opt || die "make opt failed"
}

src_install() {
	mkdir -p ${destdir}
	cp ${FILESDIR}/META ${destdir}
	make install || die "make install failed"
	dodoc doc/* README
}
