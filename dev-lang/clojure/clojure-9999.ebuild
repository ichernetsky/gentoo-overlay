# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
JAVA_PKG_IUSE="source"

inherit java-pkg-2 java-ant-2 git

DESCRIPTION="Clojure is a dynamic programming language that targets the Java Virtual Machine."
HOMEPAGE="http://clojure.org/"
EGIT_BRANCH="master"
EGIT_REPO_URI="git://github.com/richhickey/clojure.git"

LICENSE="CPL-1.0 BSD"
SLOT="0"
KEYWORDS="~x86 ~ia64 ~amd64"

IUSE=""

RDEPEND=">=virtual/jre-1.5"
DEPEND=">=virtual/jdk-1.5"

S="${WORKDIR}/${PN}"

src_prepare() {
	java-pkg-2_src_prepare
}

src_install() {
	java-pkg_dojar ${PN}.jar
	java-pkg_dolauncher  ${PN} --main clojure.lang.Repl
	dodoc readme.txt || die "dodoc failed"
	use source && java-pkg_dosrc src/jvm/closure
}
