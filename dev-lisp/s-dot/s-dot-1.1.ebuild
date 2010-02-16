# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="2"

inherit common-lisp-2

DESCRIPTION="S-Dot: A Common Lisp Interface to Graphviz Dot"
HOMEPAGE="http://www.martin-loetzsch.de/S-DOT/"
SRC_URI="http://martin-loetzsch.de/S-DOT/s-dot.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE=""

src_install() {
	common-lisp-install s-dot.{asd,lisp}
	common-lisp-symlink-asdf
}
