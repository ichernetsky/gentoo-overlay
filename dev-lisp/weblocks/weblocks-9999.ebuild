# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

WEBLOCKS_BRANCH=stable
MY_P=${PN}-${WEBLOCKS_BRANCH}
EHG_REPO_URI=http://bitbucket.org/skypher/${MY_P}/

inherit common-lisp-2 mercurial

DESCRIPTION="Weblocks is a continuations-based web framework written in Common Lisp."
HOMEPAGE="http://common-lisp.net/project/cl-weblocks/"

LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="dev-lisp/closer-mop
	dev-lisp/metatilities
	dev-lisp/hunchentoot
	dev-lisp/cl-who
	dev-lisp/cl-ppcre
	dev-lisp/cl-json
	dev-lisp/puri
	dev-lisp/md5
	dev-lisp/fare-matcher
	dev-lisp/cl-cont
	dev-lisp/parenscript
	dev-lisp/anaphora
	dev-lisp/f-underscore
	dev-lisp/bordeaux-threads
	dev-lisp/cl-fad
	dev-lisp/clsql
	dev-lisp/elephant
	dev-lisp/cl-prevalence
	dev-lisp/rt
	dev-lisp/lift
	dev-lisp/trivial-timeout"

CLSYSTEMS="${PN} ${PN}-test ${PN}-scripts ${PN}-store-test
	src/store/clsql/${PN}-clsql
	src/store/elephant/${PN}-elephant
	src/store/memory/${PN}-memory
	src/store/prevalence/${PN}-prevalence
	examples/${PN}-clsql-demo/${PN}-clsql-demo
	examples/${PN}-demo/${PN}-demo
	examples/${PN}-elephant-demo/${PN}-elephant-demo"

S="${WORKDIR}"/${MY_P}

src_install() {
	dodir "${CLSOURCEROOT}"/${PN}/scripts
	cp -a scripts/weblocks-core "${D}/${CLSOURCEROOT}"/${PN}/scripts
	rm -rf scripts/weblocks-core
	common-lisp-install *.asd examples pub scripts src test
	common-lisp-symlink-asdf
	dodoc docs/*
}
