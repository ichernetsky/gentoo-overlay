# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit common-lisp-2

MY_PV=${PV:0:4}-${PV:4:2}-${PV:6:2}

DESCRIPTION="A Common Lisp alternative to the W3C's DOM."
HOMEPAGE="http://www.lichteblau.com/cxml-stp/"
SRC_URI="http://www.lichteblau.com/${PN}/download/${PN}-${MY_PV}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="dev-lisp/cxml
		dev-lisp/alexandria
		dev-lisp/plexippus-xpath"

S="${WORKDIR}"/${PN}-${MY_PV}

src_unpack() {
	unpack ${A}
	rm "${S}"/{tutorial,}/GNUmakefile "${S}"/tutorial/tutorial.{xml,xsl}
	cd "${S}"
	epatch "${FILESDIR}/children.patch"
	epatch "${FILESDIR}/previous.patch"
}

src_install() {
	common-lisp-install *.{lisp,asd}
	common-lisp-symlink-asdf
	dodoc DOM-COMPARISON README
	dohtml -r doc || die "Cannot install HTML documentation"
	dohtml -r tutorial || die "Cannot install tutorial"
}
