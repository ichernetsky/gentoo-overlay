# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="2"
inherit eutils gnome2-utils cmake-utils git

DESCRIPTION="Darktable is a virtual lighttable and darkroom for photographers"
HOMEPAGE="http://darktable.sf.net/"
EGIT_REPO_URI="git://darktable.git.sf.net/gitroot/darktable/darktable"

EGIT_BRANCH="master"
EGIT_COMMIT="master"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="dbus gconf gphoto openmp gnome-keyring doc sdl"
RDEPEND="dev-db/sqlite:3
	doc? ( dev-java/fop )
	dbus? ( dev-libs/dbus-glib )
	>=dev-libs/libxml2-2.6
	gconf? ( gnome-base/gconf )
	gnome-base/libglade:2.0
	gnome-keyring? ( gnome-base/gnome-keyring )
	media-gfx/exiv2
	media-libs/jpeg
	media-libs/lcms:2
	>=media-libs/lensfun-0.2.3
	gphoto? ( media-libs/libgphoto2 )
	media-libs/libpng
	media-libs/libraw
	gnome-base/librsvg:2
	sdl? ( media-libs/libsdl[opengl] )
	media-libs/openexr
	media-libs/tiff
	net-misc/curl
	sys-devel/gettext
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	>=x11-libs/gtk+-2.6"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	openmp? ( >=sys-devel/gcc-4.4[openmp] )
	x11-proto/dri2proto
	x11-proto/glproto"

src_configure() {
	MYCMAKEARGS="-DDONT_INSTALL_GCONF_SCHEMAS=ON"
	MYCMAKEARGS="$MYCMAKEARGS -DAPRIL_FOOLS=OFF"
	MYCMAKEARGS="$MYCMAKEARGS $(cmake-utils_use_use openmp OPENMP)"
	MYCMAKEARGS="$MYCMAKEARGS $(cmake-utils_use_use gconf GCONF_BACKEND)"
	MYCMAKEARGS="$MYCMAKEARGS $(cmake-utils_use_use gphoto CAMERA_SUPPORT)"
	MYCMAKEARGS="$MYCMAKEARGS $(cmake-utils_use_use doc BUILD_USERMANUAL)"
	cmake-utils_src_configure
}

pkg_preinst() {
	gnome2_gconf_savelist
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_gconf_install
	gnome2_icon_cache_update
	gnome2_scrollkeeper_update
}

pkg_postrm() {
	gnome2_gconf_uninstall
	gnome2_icon_cache_update
	gnome2_scrollkeeper_update
}
