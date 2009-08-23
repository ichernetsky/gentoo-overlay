# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit common-lisp-2

MY_PV=${PV:0:4}-${PV:4:2}-${PV:6:2}

DESCRIPTION="A library of macros and functions by Fare Rideau."
HOMEPAGE="http://www.cliki.net/fare-matcher
		http://www.cliki.net/fare-matcher-docs"
SRC_URI="http://fare.tunes.org/files/asdf-packages/${PN}-${MY_PV}.tar.gz"

LICENSE="No-Problem-Bugroff"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE=""

RDEPEND="!dev-lisp/cl-${PN}
		dev-lisp/fare-utils"

S="${WORKDIR}"/${PN}

pkg_postinst() {
	while read line; do einfo ${line}; done <<EOF

The comments within the source for fare-matcher provide documentation.
You can find summarized documentation at the CLiki.

	http://www.cliki.net/fare-matcher-docs

EOF
}
