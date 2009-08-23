# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
JAVA_PKG_IUSE="source"

inherit java-pkg-2 java-ant-2 git

DESCRIPTION="User contributed packages for Clojure."
HOMEPAGE="http://clojure.org/"
EGIT_BRANCH="master"
EGIT_REPO_URI="git://github.com/richhickey/clojure-contrib.git"

LICENSE="CPL-1.0"
SLOT="0"
KEYWORDS="~x86 ~ia64 ~amd64"

IUSE=""

RDEPEND=">=virtual/jre-1.5 dev-lang/clojure"
DEPEND=">=virtual/jdk-1.5 dev-lang/clojure"

S="${WORKDIR}/${PN}"

src_prepare() {
	java-pkg-2_src_prepare
}

src_install() {
	java-pkg_dojar ${PN}.jar
	use source && java-pkg_dosrc src/clojure/contrib
}
