# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit java-pkg-2 java-ant-2

DESCRIPTION="User contributed packages for Clojure."
HOMEPAGE="http://clojure.org/"
SRC_URI="http://clojure-contrib.googlecode.com/files/clojure-contrib-1.1.0.zip"

LICENSE="CPL-1.0"
SLOT="0"
KEYWORDS="~x86 ~ia64 ~amd64"

IUSE=""

RDEPEND=">=virtual/jre-1.5
	=dev-lang/clojure-1.1.0"
DEPEND=">=virtual/jdk-1.5
	=dev-lang/clojure-1.1.0"

S="${WORKDIR}/${P}"

EANT_EXTRA_ARGS="-Dclojure.jar=/usr/share/clojure/lib/clojure.jar"

src_install() {
	   java-pkg_dojar ${PN}.jar
}
