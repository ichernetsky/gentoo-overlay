# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

ECVS_SERVER="common-lisp.net:/project/slime/cvsroot"
ECVS_MODULE="slime"
ECVS_PASS="anonymous"

inherit common-lisp-2 elisp cvs eutils

DESCRIPTION="SLIME, the Superior Lisp Interaction Mode (Extended)"
HOMEPAGE="http://common-lisp.net/project/slime/"

LICENSE="GPL-2 xref.lisp"
SLOT="0"
KEYWORDS=""
IUSE="doc"

RDEPEND="virtual/commonlisp
		dev-lisp/asdf"
DEPEND="sys-apps/texinfo
		doc? ( virtual/texi2dvi )"

S="${WORKDIR}"/${PN}

CLPACKAGE=swank
CLSYSTEMS=swank
SITEFILE=70${PN}-gentoo.el

src_unpack() {
	cvs_src_unpack
	cd "${S}"

	epatch "${FILESDIR}"/${PV}/fix-inspect-presentations.patch
	epatch "${FILESDIR}"/${PV}/fix-slime-indentation.patch
	epatch "${FILESDIR}"/${PV}/gentoo-module-load.patch
	epatch "${FILESDIR}"/${PV}/gentoo-dont-call-init.patch
	epatch "${FILESDIR}"/${PV}/gentoo-changelog-date.patch

	# extract date of last update from ChangeLog, bug 233270
	SLIME_CHANGELOG_DATE=$(awk '/^[-0-9]+ / { print $1; exit; }' ChangeLog)
	[ -n "${SLIME_CHANGELOG_DATE}" ] || die "cannot determine ChangeLog date"

	sed -i '/^section :=/d' doc/Makefile || die "sed doc/Makefile failed"
	sed -i "/(defvar \*swank-wire-protocol-version\*/s:nil:\"${SLIME_CHANGELOG_DATE}\":" swank.lisp \
		|| die "sed swank.lisp failed"
	sed -i "s:@SLIME-CHANGELOG-DATE@:${SLIME_CHANGELOG_DATE}:" slime.el \
		|| die "sed slime.el failed"
}

src_compile() {
	emake -j1 -C doc slime.info || die "Cannot build info docs"
	if use doc; then
		VARTEXFONTS="${T}"/fonts \
			emake -j1 -C doc slime.pdf || die "emake doc failed"
	fi
}

src_install() {
	## install core
	elisp-install ${PN} *.el "${FILESDIR}"/swank-loader.lisp \
		|| die "Cannot install SLIME core"
	elisp-site-file-install "${FILESDIR}"/${PV}/${SITEFILE} \
		|| die "elisp-site-file-install failed"
	cp "${FILESDIR}"/${PV}/swank.asd "${S}"
	# remove upstream swank-loader, since it won't be used
	rm "${S}"/swank-loader.lisp
	common-lisp-install *.{lisp,asd}
	common-lisp-symlink-asdf

	## install contribs
	elisp-install ${PN}/contrib/ contrib/*.{el,scm,goo} \
		|| die "Cannot install contribs"
	insinto "${CLSOURCEROOT%/}"/swank/contrib
	doins contrib/*.lisp

	## install docs
	dodoc README* ChangeLog HACKING NEWS PROBLEMS
	newdoc contrib/README README.contrib
	newdoc contrib/ChangeLog ChangeLog.contrib
	doinfo doc/slime.info
	use doc && dodoc doc/slime.pdf
}
