# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="2"

# inherit clutter after gnome2 so that defaults aren't overriden
inherit gnome2 clutter git

DESCRIPTION="Clutter-GTK - GTK+ Integration library for Clutter"
EGIT_BRANCH="master"
EGIT_REPO_URI="git://git.clutter-project.org/clutter-gtk.git"
SRC_URI=""

SLOT="1.0"
KEYWORDS="~amd64 ~x86"
IUSE="doc debug examples +introspection"

# XXX: Needs gtk with X support (!directfb)
RDEPEND="
	>=x11-libs/gtk+-2.19.5[introspection?]
	>=media-libs/clutter-1.2:1.0[introspection?]
	introspection? ( >=dev-libs/gobject-introspection-0.6.4 )"
DEPEND="${RDEPEND}
	doc? ( >=dev-util/gtk-doc-1.11 )"
EXAMPLES="examples/{*.c,redhand.png}"

src_configure() {
	gtkdocize || die "gtkdocize failed"
	autoreconf -f -i || "autoreconf failed"
	gnome2_src_configure
}

pkg_setup() {
	G2CONF="${G2CONF}
		--with-flavour=x11
		--enable-maintainer-flags=no
		$(use_enable introspection)"
}
