# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
GCONF_DEBUG="yes"

inherit autotools eutils gnome2 toolchain-funcs

DESCRIPTION="Internationalized text layout and rendering library"
HOMEPAGE="http://www.pango.org/"

LICENSE="LGPL-2 FTL"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE="X doc test introspection"

RDEPEND=">=dev-libs/glib-2.17.3
	>=media-libs/fontconfig-2.5.0
	media-libs/freetype:2
	>=x11-libs/cairo-1.7.6[X?]
	X? (
		x11-libs/libXrender
		x11-libs/libX11
		x11-libs/libXft )"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	dev-util/gtk-doc-am
	doc? (
		>=dev-util/gtk-doc-1
		~app-text/docbook-xml-dtd-4.1.2
		x11-libs/libXft )
	test? (
		>=dev-util/gtk-doc-1
		~app-text/docbook-xml-dtd-4.1.2
		x11-libs/libXft )
	X? ( x11-proto/xproto )
	introspection? ( >=dev-libs/gobject-introspection-0.6.4 )
	!dev-libs/gir-repository[pango]"

DOCS="AUTHORS ChangeLog* NEWS README THANKS"

pkg_setup() {
	tc-export CXX
	G2CONF="${G2CONF}
		--enable-introspection
		$(use_with X x)"
}

pkg_postinst() {
	if [ "${ROOT}" = "/" ] ; then
		einfo "Generating modules listing..."
		local PANGO_CONFDIR="/etc/pango"
		mkdir -p ${PANGO_CONFDIR}
		pango-querymodules > ${PANGO_CONFDIR}/pango.modules
	fi
}
