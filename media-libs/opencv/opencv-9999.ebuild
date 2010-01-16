# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit cmake-utils subversion

DESCRIPTION="The Open Computer Vision Library is a library for real-time computer vision."
HOMEPAGE="http://opencv.willowgarage.com/"
SRC_URI=""

LICENSE="v4l? ( GPL-2 ) xine? ( GPL-2 ) Intel"
KEYWORDS="~x86 ~ia64 ~amd64"
SLOT="0"

ESVN_REPO_URI="https://code.ros.org/svn/opencv/trunk/opencv"

IUSE="debug deprecated examples ffmpeg gstreamer gtk ieee1394 ipp jpeg jpeg2k
	mmx octave openmp png python sse sse2 sse3 test tiff v4l xine"

RDEPEND="sys-libs/zlib
	ipp? ( sci-libs/ipp )
	python? ( >=dev-lang/python-2.5
		deprecated? ( dev-lang/swig ) )
	ieee1394? ( sys-libs/libraw1394
		media-libs/libdc1394:2 )
	ffmpeg? ( >=media-video/ffmpeg-0.5 )
	gstreamer? ( media-libs/gstreamer )
	gtk? ( x11-libs/gtk+:2 )
	jpeg2k? ( media-libs/jasper )
	jpeg? ( media-libs/jpeg )
	png? ( media-libs/libpng )
	tiff? ( media-libs/tiff )
	xine? ( media-libs/xine-lib )
	octave? ( sci-mathematics/octave
		dev-lang/swig )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DCMAKE_SKIP_RPATH=ON
		$(cmake-utils_use_build examples)
		$(cmake-utils_use_build python NEW_PYTHON_SUPPORT)
		$(cmake-utils_use_build octave OCTAVE_SUPPORT)
		$(cmake-utils_use_build test TESTS)
		$(cmake-utils_use_enable openmp)
		$(cmake-utils_use ipp USE_IPP)
		$(cmake-utils_use mmx USE_MMX)
		-DUSE_O3=OFF
		-DUSE_OMIT_FRAME_POINTER=OFF
		$(cmake-utils_use sse USE_SSE)
		$(cmake-utils_use sse2 USE_SSE2)
		$(cmake-utils_use sse3 USE_SSE3)
		$(cmake-utils_use_with ieee1394 1394)
		$(cmake-utils_use_with ffmpeg)
		$(cmake-utils_use_with gstreamer)
		$(cmake-utils_use_with gtk)
		$(cmake-utils_use_with jpeg2k jasper)
		$(cmake-utils_use_with jpeg)
		$(cmake-utils_use_with png)
		$(cmake-utils_use_with tiff)
		-DWITH_UNICAP=OFF
		$(cmake-utils_use_with v4l)
		$(cmake-utils_use_with xine)"

	if use python; then
		mycmakeargs="${mycmakeargs}
			$(cmake-utils_use_build deprecated SWIG_PYTHON_SUPPORT)"
	fi

	cmake-utils_src_configure
}
