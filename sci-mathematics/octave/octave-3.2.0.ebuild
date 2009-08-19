# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit fortran

DESCRIPTION="High-level interactive language for numerical computations"
LICENSE="GPL-3"
HOMEPAGE="http://www.octave.org/"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/${PN}/${P}.tar.gz"

SLOT="0"
IUSE="zlib hdf5 fftw glpk curl readline qrupdate sparse arpack ftgl fltk magick doc emacs xemacs"
KEYWORDS="~x86"

RDEPEND="media-libs/qhull
	dev-libs/libpcre
	sys-libs/ncurses
	virtual/lapack
	virtual/blas
	sci-visualization/gnuplot
	zlib? ( sys-libs/zlib )
	hdf5? ( sci-libs/hdf5 )
	fftw? ( >=sci-libs/fftw-3.2 )
	glpk? ( >=sci-mathematics/glpk-4.15 )
	curl? ( net-misc/curl )
	readline? ( sys-libs/readline )
	qrupdate? ( sci-libs/qrupdate )
	sparse? ( sci-libs/umfpack
		sci-libs/colamd
		sci-libs/amd
		sci-libs/camd
		sci-libs/ccolamd
		sci-libs/cholmod
		sci-libs/cxsparse )
	arpack? ( sci-libs/arpack )
	ftgl? ( media-libs/ftgl )
	fltk? ( x11-libs/fltk[opengl] )
	magick? ( media-gfx/graphicsmagick[cxx] )
	emacs? ( || ( app-editors/emacs
		app-editors/emacs-cvs ) )
	xemacs? ( app-editors/xemacs )
	!sci-mathematics/octave-forge"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/gperf
	virtual/latex-base
	|| ( dev-texlive/texlive-genericrecommended
		app-text/ptex )
	sys-apps/texinfo"

FORTRAN="gfortran ifc g77 f2c"

src_configure() {
	use hdf5 && ! use zlib && die "zlib use-flag required to be enabled by hdf5 use-flag"

	econf \
		--localstatedir=/var/state/octave \
		--enable-shared \
		--with-blas="$(pkg-config --libs blas)" \
		--with-lapack="$(pkg-config --libs lapack)" \
		$(use_with zlib) \
		$(use_with hdf5) \
		$(use_with fftw) \
		$(use_with glpk) \
		$(use_with curl) \
		$(use_with sparse umfpack) \
		$(use_with sparse colamd) \
		$(use_with sparse amd) \
		$(use_with sparse camd) \
		$(use_with sparse ccolamd) \
		$(use_with sparse cholmod) \
		$(use_with sparse cxsparse) \
		$(use_with arpack) \
		$(use_enable readline)

}

src_compile() {
	emake || die "emake failed"

	if use xemacs; then
		cd "${S}/emacs"
		xemacs-elisp-comp *.el
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	if use doc; then
		einfo "Installing documention..."
		insinto /usr/share/doc/${PF}
		doins $(find doc -name \*.pdf)
	fi

	if use emacs || use xemacs; then
		cd emacs
		exeinto /usr/bin
		doexe octave-tags || die "Failed to install octave-tags."
		doman octave-tags.1 || die "Failed to install octave-tags.1"
		if use xemacs; then
			xemacs-elisp-install ${PN} *.el *.elc
		fi
		cd ..
	fi
}