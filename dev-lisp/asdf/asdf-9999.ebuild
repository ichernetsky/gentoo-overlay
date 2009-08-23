# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

EGIT_BRANCH="master"
EGIT_REPO_URI="git://common-lisp.net/projects/asdf/asdf.git"

inherit common-lisp-2 eutils git

DESCRIPTION="ASDF is Another System Definition Facility for Common Lisp"
HOMEPAGE="http://www.cliki.net/asdf"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~ia64 ~amd64"
IUSE=""

RDEPEND="!dev-lisp/cl-${PN}
	virtual/commonlisp"

src_compile() {
	:
}

src_install() {
	common-lisp-install {asdf,wild-modules,asdf-install}.lisp
	dodoc README
	docinto examples && dodoc test/*
}
