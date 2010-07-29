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

IUSE="cuda debug doc eigen2 examples ffmpeg gstreamer gtk ieee1394 ipp jpeg jpeg2k
	openexr png python sse sse2 sse3 tbb test tiff v4l xine"

RDEPEND="sys-libs/zlib
	cuda? ( dev-util/nvidia-cuda-sdk )
	doc? ( app-doc/doxygen )
	eigen2? ( dev-cpp/eigen:2 )
	ffmpeg? ( >=media-video/ffmpeg-0.5 )
	gstreamer? ( >=media-libs/gstreamer-0.10 )
	gtk? ( x11-libs/gtk+:2 )
	ieee1394? ( sys-libs/libraw1394
		media-libs/libdc1394:2 )
	ipp? ( sci-libs/ipp )
	jpeg? ( media-libs/jpeg )
	jpeg2k? ( media-libs/jasper )
	openexr? ( media-libs/openexr )
	png? ( media-libs/libpng )
	python? ( >=dev-lang/python-2.5
		dev-python/numpy )
	tbb? ( dev-cpp/tbb )
	tiff? ( media-libs/tiff )
	v4l? ( media-libs/libv4l )
	xine? ( media-libs/xine-lib )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DCMAKE_SKIP_RPATH=ON
		-DUSE_O3=OFF
		-DUSE_OMIT_FRAME_POINTER=ON
		-DBUILD_SHARED_LIBS=ON
		-DUSE_FAST_MATH=ON
		-DOPENCV_BUILD_3RDPARTY_LIBS=OFF
		-DWITH_UNICAP=OFF
		-DWITH_PVAPI=OFF
		-DWITH_QT=OFF
		-DWITH_QT_OPENGL=OFF
		-DBUILD_LATEX_DOCS=OFF
		$(cmake-utils_use_build examples)
		$(cmake-utils_use_build test TESTS)
		$(cmake-utils_use_enable sse)
		$(cmake-utils_use_enable sse2)
		$(cmake-utils_use_enable sse3)
		$(cmake-utils_use_with png)
		$(cmake-utils_use_with jpeg)
		$(cmake-utils_use_with jpeg2k JASPER)
		$(cmake-utils_use_with tiff)
		$(cmake-utils_use_with openexr)
		$(cmake-utils_use_with ffmpeg)
		$(cmake-utils_use_with gtk)
		$(cmake-utils_use_with xine)
		$(cmake-utils_use_with ieee1394 1394)
		$(cmake-utils_use_with tbb)
		$(cmake-utils_use_with eigen2)
		$(cmake-utils_use_with cuda)
		$(cmake-utils_use_with gstreamer)
		$(cmake-utils_use_with v4l)
		$(cmake-utils_use_use ipp)
		$(cmake-utils_use_build python NEW_PYTHON_SUPPORT)
		$(cmake-utils_use doc BUILD_DOXYGEN_DOCS)"

	if use debug; then
		mycmakeargs="${mycmakeargs}
			-DCMAKE_BUILD_TYPE=Debug"
	fi

	cmake-utils_src_configure
}
