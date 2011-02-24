# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="2"

inherit distutils

DESCRIPTION="doxypy is an input filter for Doxygen."
HOMEPAGE="http://code.foosel.org/doxypy"
SRC_URI="http://code.foosel.org/files/${P}.tar.gz"
LICENSE="GPLv2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="app-doc/doxygen"
