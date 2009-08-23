# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit common-lisp-2 darcs

DESCRIPTION="A Common Lisp library implementing an abstraction layer over platform dependent functionality."
HOMEPAGE="http://homepage.mac.com/svc/s-sysdeps/"
EDARCS_REPOSITORY="http://www.beta9.be/darcs/s-sysdeps"

LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE=""

RDEPEND="!dev-lisp/cl-${PN}"

src_compile() {
	:
}

src_install() {
	common-lisp-install src test *.asd
	common-lisp-symlink-asdf
	dohtml doc/*.html
	dodoc README.txt
}
