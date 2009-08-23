# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit common-lisp-2

DESCRIPTION="cl-launch is a utility to make Common Lisp software easily invokable from the command-line."
HOMEPAGE="http://www.cliki.net/cl-launch"
SRC_URI="http://common-lisp.net/project/xcvb/${PN}/${PN}_${PV}.tar.gz"

LICENSE="No-Problem-Bugroff LLGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE=""

CL_LAUNCH_FASLDIR=/var/cache/cl-launch

src_install() {
	dobin cl-launch.sh
	common-lisp-install launcher.lisp wrapper.sh cl-launch.asd
	common-lisp-symlink-asdf
	keepdir "${CL_LAUNCH_FASLDIR}"
	fperms 1777 "${CL_LAUNCH_FASLDIR}"
}
