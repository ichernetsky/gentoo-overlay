# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

LIBTOOLIZE="true"
inherit autotools subversion

DESCRIPTION="The Open Computer Vision Library is a library for real-time computer vision."
HOMEPAGE="http://opencv.willowgarage.com/"

LICENSE="ffmpeg? ( GPL-2 ) xine? ( GPL-2 ) gstreamer? ( LGPL-2.1 ) unicap? ( GPL-2 ) BSD"
KEYWORDS="~x86 ~ia64 ~amd64"
SLOT="0"

ESVN_REPO_URI="https://opencvlibrary.svn.sourceforge.net/svnroot/opencvlibrary/trunk/opencv"

IUSE="debug examples ffmpeg gstreamer gthread gtk ieee1394 jpeg jpeg2k octave openexr openmp png python quicktime sse swig tiff unicap v4l xine zlib"

RDEPEND="openmp? ( >=sys-devel/gcc-4.2[openmp] )
	swig? ( >=dev-lang/swig-1.3.30 )
	python? ( >=dev-lang/python-2.5 )
	octave? ( >=sci-mathematics/octave-2.9.12 )
	xine? ( media-libs/xine-lib )
	gstreamer? ( >=media-libs/gstreamer-0.10 )
	ffmpeg? ( media-video/ffmpeg )
	ieee1394? ( media-libs/libdc1394 sys-libs/libraw1394 )
	unicap? ( media-libs/unicap )
	quicktime? ( media-libs/libquicktime )
	gtk? ( >=x11-libs/gtk+-2 )
	gthread? ( dev-libs/glib )
	jpeg? ( media-libs/jpeg )
	jpeg2k? ( media-libs/jasper )
	zlib? ( sys-libs/zlib )
	tiff? ( media-libs/tiff )
	png? ( >=media-libs/libpng-1.2 )
	openexr? ( media-libs/openexr )"

DEPEND="${RDEPEND}
	>=sys-devel/autoconf-2.63
	>=sys-devel/automake-1.9
	gstreamer? ( dev-util/pkg-config )"

pkg_setup() {
	use quicktime && use ffmpeg && die "You cannot specify quicktime and ffmpeg use flags at the same time"
	use quicktime && use xine && die "You cannot specify quicktime and xine use flags at the same time"
	use quicktime && use ieee1394 && die "You cannot specify quicktime and ieee1394 use flags at the same time"
	use quicktime && use v4l && die "You cannot specify quicktime and v4l use flags at the same time"
	use gstreamer && use ffmpeg && die "You cannot specify gstreamer and ffmpeg use flags at the same time"
}

src_prepare() {
	sed -i "s:ffmpeg/avcodec.h:libavcodec/avcodec.h:g" "${S}/configure.in"
	sed -i "s:ffmpeg/swscale.h:libswscale/swscale.h:g" "${S}/configure.in"
	sed -i "s:<ffmpeg/avformat.h>:<libavformat/avformat.h>:g" "${S}/src/highgui/cvcap_ffmpeg.cpp"
	sed -i "s:<ffmpeg/avcodec.h>:<libavcodec/avcodec.h>:g" "${S}/src/highgui/cvcap_ffmpeg.cpp"
	sed -i "s:<ffmpeg/swscale.h>:<libswscale/swscale.h>:g" "${S}/src/highgui/cvcap_ffmpeg.cpp"
	eautoreconf
}

src_configure() {
	local enable_optimization;
	if use debug; then
		enable_optimization="";
	else
		enable_optimization="--enable-optimization";
	fi

	econf \
		--enable-shared \
		--without-native-lapack \
		${enable_optimization} \
		$(use_enable debug) \
		$(use_enable examples apps) \
		$(use_with ffmpeg) \
		$(use_with gstreamer) \
		$(use_with gthread) \
		$(use_with gtk) \
		$(use_with ieee1394 1394libs) \
		$(use_with octave) \
		$(use_enable openmp) \
		$(use_with python) \
		$(use_with quicktime) \
		$(use_enable sse) \
		$(use_with swig) \
		$(use_with unicap) \
		$(use_with v4l) \
		$(use_with xine)
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
