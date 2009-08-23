# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit flag-o-matic subversion

DESCRIPTION="NYARToolKit is a software library for building Augmented Reality (AR) applications."
HOMEPAGE="http://nyatla.jp/nyartoolkit/wiki/index.php?FrontPage.en"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ia64 ~amd64"
SLOT="0"

ESVN_REPO_URI="http://svn.sourceforge.jp/svnroot/nyartoolkit/NyARToolkitCPP/trunk/"

RDEPEND=""

DEPEND=""

src_compile() {
	epatch "${FILESDIR}"/qualification_bug.diff
	cd "${S}/forLinux/libNyARToolkit"
	emake -j1 || die "emake failed"
	cd "${S}"
}

src_install() {
	dolib.a forLinux/libNyARToolkit/lib/libnyartoolkit.a
	dodir /usr/include/NyARToolkit
	insinto /usr/include/NyARToolkit
	cd "${S}/inc"
	doins NyAR_core.h NyAR_utils.h
	cd "${S}/inc/core"
	insinto /usr/include/NyARToolkit/core
	doins *.h
	cd "${S}/inc/utils"
	insinto /usr/include/NyARToolkit/utils
	doins *.h
	cd "${S}"
}