# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit autotools clutter

DESCRIPTION="Clutter is an open source library for creating fast, visually rich, portable and animated GUI"

SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE="X debug doc introspection"

RDEPEND=">=dev-libs/glib-2.16
	>=x11-libs/cairo-1.6[X?]
	>=x11-libs/pango-1.20[X?,introspection?]
	>=x11-libs/gtk+-2.0
	virtual/opengl
	>=dev-libs/json-glib-0.8[introspection?]
	X? ( x11-libs/libX11
		x11-libs/libXext
		>=x11-libs/libXfixes-3
		x11-libs/libXdamage
		x11-libs/libXcomposite )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext
	dev-util/gtk-doc-am
	doc? ( >=dev-util/gtk-doc-1.11
		dev-libs/libxslt
		>=app-text/docbook-sgml-utils-0.6.14[jadetex] )
	introspection? ( >=dev-libs/gobject-introspection-0.6.4 )
	X? ( x11-proto/inputproto )"

src_configure() {
	local myconf=""

	if use debug; then
		myconf="${myconf}
			--enable-debug=yes
			--enable-cogl-debug=yes"
	else
		myconf="${myconf}
			--enable-debug=minimum
			--enable-cogl-debug=minimum"
	fi

	if use doc; then
		myconf="${myconf}
			--enable-gtk-doc
			--enable-docs=yes"
	fi

	if use X; then
		myconf="${myconf}
			--with-x
			--enable-xinput"
	fi

	if use introspection; then
		myconf="${myconf}
			--enable-introspection=yes"
	else
		myconf="${myconf}
			--enable-introspection=no"
	fi

	myconf="${myconf}
		--with-json=system
		--with-imagebackend=gdk-pixbuf
		--with-flavour=glx
		--enable-maintainer-flags=no
		--enable-conformance=no"

	econf ${myconf}
}

# src_prepare() {
# 	# Make it libtool-1 compatible
# 	rm -v build/autotools/lt* build/autotools/libtool.m4 || die "removing libtool macros failed"
#
# 	eautoreconf
# }
