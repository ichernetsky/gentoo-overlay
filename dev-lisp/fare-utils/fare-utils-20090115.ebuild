# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit common-lisp-2

MY_PV=${PV:0:4}-${PV:4:2}-${PV:6:2}

DESCRIPTION="A collection of small utilities by Fare Rideau."
HOMEPAGE="http://www.cliki.net/fare-utils"
SRC_URI="http://fare.tunes.org/files/asdf-packages/${PN}-${MY_PV}.tar.gz"

LICENSE="No-Problem-Bugroff"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE=""

RDEPEND="!dev-lisp/cl-${PN}"

S="${WORKDIR}"/${PN}
