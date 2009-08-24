# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit common-lisp-2 darcs

DESCRIPTION="A Common Lisp library providing means to run actions with a time-out."
HOMEPAGE="http://common-lisp.net/project/trivial-timeout/"
EDARCS_REPOSITORY="http://common-lisp.net/project/trivial-timeout/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE=""

src_install() {
	common-lisp-install dev website asdf-featurep.lisp trivial-timeout.asd
	common-lisp-symlink-asdf
	dodoc COPYING
}
