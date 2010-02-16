# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
JAVA_PKG_IUSE="source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Clojure is a dynamic programming language that targets the Java Virtual Machine."
HOMEPAGE="http://clojure.org/"
SRC_URI="http://clojure.googlecode.com/files/clojure-1.1.0.zip"

LICENSE="EPL-1.0 BSD"
SLOT="0"
KEYWORDS="~x86 ~ia64 ~amd64"

IUSE=""

RDEPEND=">=virtual/jre-1.5"
DEPEND=">=virtual/jdk-1.5"

S="${WORKDIR}/${PN}-${PV}"

src_install() {
	java-pkg_dojar ${PN}.jar
	java-pkg_dolauncher ${PN} --main clojure.main
	dodoc readme.txt || die "cannot dodoc readme.txt"
	dodoc epl-v10.html || die "cannot dodoc epl-v10.html"
	use source && java-pkg_dosrc src/jvm/clojure
}