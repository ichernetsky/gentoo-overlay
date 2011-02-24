# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

# Note: Although this ebuild has the approval of the SXEmacs Project,
# it is not an official subset of the project and thus only limited
# support can be offered for this ebuild.

inherit eutils flag-o-matic

DESCRIPTION="A text editing and development environment based on XEmacs that aims to be second to none in regards to stability, features, and innovation."
HOMEPAGE="http://www.sxemacs.org/"
SRC_URI="http://downloads.sxemacs.org/releases/${P}.tar.lzma
		http://www.malfunction.de/afterstep/files/NeXT_XEmacs.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd"
MAKEOPTS="-j1"

IUSE="X alsa jack pulseaudio oss nas arts ao esd gif png jpeg xface tiff ffmpeg mad bdwgc
	  sndfile sox ssl tls ipv6 pop kerberos hesiod postgresql ffi gmp mpfr magic xpm
	  athena neXt Xaw3d motif xim canna freewnn gdbm berkdb tty gpm ncurses mule socks
	  omgoptimize warnfull"

X_DEPEND="x11-libs/libXt x11-libs/libXmu x11-libs/libXext x11-misc/xbitmaps"

DEPEND="virtual/libc
		=sys-libs/zlib-1.2*
		app-arch/bzip2
		>=media-libs/audiofile-0.2.3
		X? ( $X_DEPEND !Xaw3d? ( !neXt? ( x11-libs/libXaw ) ) )
		alsa? ( media-sound/alsa-headers )
		jack? ( media-sound/jack )
		pulseaudio? ( media-sound/pulseaudio )
		nas? ( media-libs/nas )
		arts? ( kde-base/arts )
		ao? ( >=media-libs/libao-0.8.5 )
		esd? ( media-sound/esound )
		png? ( =media-libs/libpng-1.2* )
		jpeg? ( media-libs/jpeg )
		xface? ( media-libs/compface )
		tiff? ( media-libs/tiff )
		ffmpeg? ( media-video/ffmpeg )
		mad? ( media-libs/libmad media-sound/madplay )
		bdwgc? ( dev-libs/boehm-gc )
		sndfile? ( media-libs/libsndfile )
		sox? ( media-sound/sox )
		ssl? ( >=dev-libs/openssl-0.9.8 )
		tls? ( >=net-libs/gnutls-2.0.4 )
		kerberos? ( app-crypt/mit-krb5 )
		hesiod? ( net-dns/hesiod )
		postgresql? ( dev-db/postgresql-base )
		gmp? ( dev-libs/gmp )
		mpfr? ( dev-libs/mpfr )
		athena? ( x11-libs/libXaw )
		neXt? ( x11-libs/neXtaw )
		Xaw3d? ( x11-libs/Xaw3d )
		motif? ( >=x11-libs/openmotif-2.1.30 )
		canna? ( app-i18n/canna )
		freewnn? ( app-i18n/freewnn )
		gdbm? ( >=sys-libs/gdbm-1.8.3 )
		berkdb? ( sys-libs/db )
		gpm? ( sys-libs/gpm )
		ncurses? ( >=sys-libs/ncurses-5.2 )
		magic? ( sys-apps/file )"

PDEPEND="app-xemacs/xemacs-base
		 mule? ( app-xemacs/mule-base )"

PROVIDE="virtual/sxemacs"

pkg_setup() {
		if use ffi && ! built_with_use sys-devel/gcc libffi ; then
				eerror "sys-devel/gcc not built with libffi support"
				eerror "rebuild sys-devel/gcc with USE=\"libffi\" or"
				eerror "turn off the libffi use flag on ${PN}"
				die "Rebuild gcc with libffi support or don't use FFI."
		fi

		if use ffi && built_with_use sys-devel/gcc libffi ; then
				elog "You've elected to build SXEmacs with FFI support."
				elog "This will allow you to view in SXEmacs any image type"
				elog "supported by ImageMagick's libWand."
				elog "It will also allow you to download the initial XE packages"
				elog "from within SXEmacs itself. To do this, use"
				elog "            M-x pui-bootstrap RET"
		fi

		if use bdwgc ; then
				ewarn "You've elected to compile SXEmacs with support for the"
				ewarn "Boehm-Demers-Weiser Garbage Collector, or Boehm-GC."
				ewarn "The BDWGC code is still in its infancy, and is known to"
				ewarn "consume larger-than-average amounts of memory in an SXEmacs"
				ewarn "session. You have been warned."
		fi

		ewarn "Note: Although this ebuild has the approval of the SXEmacs Project,"
		ewarn "it is not an official subset of the project and thus only limited"
		ewarn "support can be offered for this ebuild. "
}

src_unpack() {
		unpack ${P}.tar.lzma
		use neXt && unpack NeXT_XEmacs.tar.gz

		use neXt && cp "${WORKDIR}"/NeXT.XEmacs/xemacs-icons/* "${S}"/etc/toolbar/
}

src_compile() {

		#####################################
		# Allow SXEmacs to decide on CFLAGS #
		#####################################
		# Don't know why a higher value won't work on some Gentoo systems, but to be
		# safe and ensure that users don't whinge too much, we'll arbitrate -O2 as
		# the optimisation level.
		# Also work around hardened compiler bugs.
		replace-flags -O* -O2
		filter-flags -fomit-frame-pointer -fPIE
		is-flag -nopie && append-flags -nopie

		#################
		# Configuration #
		#################
		local myconf=""

			#######################
			# Configuration for X #
			#######################
			if use X ; then
				myconf="${myconf} --with-widgets=athena"
				myconf="${myconf} --with-dialogs=athena"
				myconf="${myconf} --with-menubars=lucid"
				myconf="${myconf} --with-scrollbars=lucid"
			if use motif ; then
				myconf="--with-widgets=motif"
				myconf="${myconf} --with-dialogs=motif"
				myconf="${myconf} --with-scrollbars=motif"
				myconf="${myconf} --with-menubars=lucid"
			fi
			if use athena ; then
				myconf="--with-scrollbars=athena"
			fi
			if use Xaw3d ; then
				myconf="${myconf} --with-athena=3d"
			elif use neXt ; then
				myconf="${myconf} --with-athena=next"
			else
				myconf="${myconf} --with-athena=xaw"
			fi

			else
				myconf="${myconf} --without-x"
			fi

			#########################
			# Configuration for TTY #
			#########################
			local ttyconf=""
			if use tty ; then
			ttyconf="${ttyconf} --with-tty"
			if use tty ; then
				if use ncurses ; then
						ttyconf="${ttyconf} --with-ncurses"
				else
						ttyconf="${ttyconf} --without-ncurses"
				fi
				if use gpm ; then
						ttyconf="${ttyconf} --with-gpm"
				else
						ttyconf="${ttyconf} --without-gpm"
				fi
			fi
			else
				ttyconf="${ttyconf} --without-tty"
			fi
			myconf="${myconf} ${ttyconf}"


			######################
			# MULE Configuration #
			######################
			if use mule ; then
			myconf="${myconf} --with-mule"
			if use xim ; then
				if use motif ; then
						myconf="${myconf} --with-xim=motif"
				else
						myconf="${myconf} --with-xim=xlib"
				fi
			else
				myconf="${myconf} --with-xim=no"
			fi
				use canna && myconf="${myconf} --with-canna"
				use freewnn && myconf="${myconf} --with-wnn"
			else
				myconf="${myconf} --without-mule"
			fi

			#######################
			# Sound Configuration #
			#######################
			local soundconf="none"
			# Define what sound outputs we use
			use alsa && soundconf="${soundconf},alsa"
			use jack && soundconf="${soundconf},jack"
			use pulseaudio && soundconf="${soundconf},pulse"
			use oss && soundconf="${soundconf},oss"
			use nas && soundconf="${soundconf},nas"
			use arts && soundconf="${soundconf},arts"
			use ao && soundconf="${soundconf},ao"
			use esd && soundconf="${soundconf},esd"
			# And make them work
			myconf="${myconf} --with-sound=${soundconf}"

			########################
			# Images Configuration #
			########################
			local imageconf="none"
			# Define Image Types to support
			use gif && imageconf="${imageconf},gif"
			use png && imageconf="${imageconf},png"
			use jpeg && imageconf="${imageconf},jpeg"
			use xface && imageconf="${imageconf},xface"
			use tiff && imageconf="${imageconf},tiff"
			use xpm && imageconf="${imageconf},xpm"
			# And make them work
			myconf="${myconf} --with-image=${imageconf}"
			# Note - If FFI useflag is set, and ImageMagick is installed, SXEmacs
			# will make use of libWand and can thus display many more types of
			# image.

			##########################
			# Database Configuration #
			##########################
			local mydb="none"
			use gdbm && mydb="${mydb},gdbm"
			use berkdb && mydb="${mydb},berkdb"
			myconf="${myconf} --with-database=${mydb}"
			# and add support for postgre here
			use postgresql && myconf="${myconf} --with-postgresql" || myconf="${myconf} --without-postgresql"

			#######################
			# Media Configuration #
			#######################
			local mediaconf="none,internal"
			# Define Media Types to support
			use ffmpeg && mediaconf="${mediaconf},ffmpeg"
			use mad && mediaconf="${mediaconf},mad"
			use sndfile && mediaconf="${mediaconf},sndfile"
			use magic && mediaconf="${mediaconf},magic"
			use sox && mediaconf="${mediaconf},sox"
			# And make them work
			myconf="${myconf} --with-media=${mediaconf}"

			########################
			# Cryptography Options #
			########################
			local crypto=""
			use ssl && crypto="${crypto} --with-openssl"
			use tls && crypto="${crypto} --with-gnutls"
			myconf="${myconf} ${crypto}"

			############################
			# Networking Configuration #
			############################
			local netconf=""
			use pop && netconf="${netconf} --with-pop" || netconf="${netconf} --without-pop"
			use kerberos && netconf="${netconf} --with-kerberos" || netconf="${netconf} --without-kerberos"
			use hesiod && netconf="${netconf} --with-hesiod"
			use socks && netconf="${netconf} --with-socks"
			myconf="${myconf} ${netconf}"

			#######
			# FFI #
			#######
			use ffi && myconf="${myconf} --with-ffi"

			#########################################
			# Boehm-Demers-Weiser Garbage Collector #
			#########################################
			use bdwgc && myconf="${myconf} --with-experimental-features=all"

			############################
			# Aggressive Optimisations #
			############################
			use omgoptimize && myconf="${myconf} --with-ridiculously-aggressive-optimisations"

			##########################
			# Maximum Warning Output #
			##########################
			use warnfull && myconf="${myconf} --with-maximum-warning-output"

			####################
			# Neat Math Tricks #
			####################
			# I'm going to let SXEmacs do the deciding here.
			# The useflags will simply be for dependencies.
			myconf="${myconf} --with-ent=all --with-ase=all"

			##################
			# Module Support #
			##################
			myconf="${myconf} --with-module-support"
			myconf="${myconf} --with-modules=all"

		########################
		# End of Configuration #
		########################

		###############
		# ./configure #
		###############

		tuple=$(configgmp.guess)
		./configure --prefix=/usr ${myconf} || die "The SXEmacs Configure Script failed to run correctly."

		#################
		# Build SXEmacs #
		#################

		emake beta check || die "The SXEmacs Build Process (compilation) failed."

}

src_install() {
		###################
		# Install SXEmacs #
		###################

		emake prefix="${D}"/usr mandir="${D}"/usr/share/man/man1 infodir="${D}"/usr/share/info install gzip-el

		dodir /usr/share/sxemacs/xemacs-packages/
		dodir /usr/share/sxemacs/sxemacs-packages/
		dodir /usr/share/sxemacs/site-packages/
		dodir /usr/lib/sxemacs/${tuple}/modules/
		dodir /usr/lib/${P}/${tuple}/modules/
		dodir /usr/lib/sxemacs/${tuple}/site-modules/
		dodir /usr/lib/${P}/${tuple}/site-modules/

		if use mule;
		then
		dodir /usr/share/sxemacs/mule-packages
		fi

		insinto /usr/share/pixmaps
		newins "${S}"/etc/${PN}-icon3.xpm ${PN}.xpm

		insinto /usr/share/applications
		doins "${S}"/etc/${PN}.desktop

}


pkg_postinst() {
		eselect emacs update --if-unset
}

pkg_postrm() {
		eselect emacs update --if-unset
}
