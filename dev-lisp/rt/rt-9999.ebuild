# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit common-lisp-2 eutils git

DESCRIPTION="Common Lisp regression tester from MIT"
HOMEPAGE="http://www-2.cs.cmu.edu/afs/cs/project/ai-repository/ai/lang/lisp/code/testing/rt/
		http://packages.debian.org/unstable/devel/cl-rt.html
		http://www.cliki.net/rt"
EGIT_REPO_URI="http://git.b9.com/rt.git"
EGIT_BRANCH="master"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ia86 ~x86"
IUSE=""

RDEPEND="!dev-lisp/cl-${PN}"

S="${WORKDIR}/cl-${P}"

src_install() {
	common-lisp-install ${PN}.{lisp,asd}
	common-lisp-symlink-asdf
	dodoc rt-doc.txt rt-test.lisp || die "Cannot install tests"
}
