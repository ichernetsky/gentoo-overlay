# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="2"

inherit elisp

MY_PN="ProofGeneral"
MY_PV="${PV/_p20/pre}"
DESCRIPTION="A generic interface for proof assistants"
HOMEPAGE="http://proofgeneral.inf.ed.ac.uk/"
SRC_URI="http://proofgeneral.inf.ed.ac.uk/releases/${MY_PN}-${MY_PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"

RDEPEND="|| ( >=app-editors/emacs-vcs-22.2
	>=app-editors/emacs-22.2 )"

DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_PN}-${MY_PV}"
SITEFILE="50${PN}-gentoo.el"

src_unpack() {
	unpack "${A}"
	cd "${S}" && emake clean || die "clean failed"
}

src_prepare() {
	cd "${S}" && emake clean || die "clean failed"
	epatch "${FILESDIR}/save-excursion.patch"
}

src_compile() {
	emake compile EMACS=emacs -j1 || die "compile failed"
	emake doc EMACS=emacs || die "doc failed"
}

src_install() {
	emake install EMACS=emacs PREFIX="${D}"/usr || die "install failed"
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" ${MY_PN} || die "sitefile install failed"

	doman doc/proofgeneral.1 || die "doman failed"
	dodoc AUTHORS BUGS CHANGES COMPATIBILITY COPYING FAQ INSTALL README REGISTER
	if use doc; then
		doinfo doc/*.info* || die "doinfo failed"
		dodoc doc/*.pdf
		dohtml doc/ProofGeneral/*.html doc/PG-adapting/*.html || die "dohtml failed"
	fi

	# clean up
	rm -rf "${D}/usr/share/emacs/site-lisp/site-start.d"
	rm -rf "${D}/usr/share/application-registry"
	rm -rf "${D}/usr/share/mime-info"
}

pkg_postinst() {
	elisp-site-regen
	elog "Please register your use of Proof General on the web at:"
	elog "  http://proofgeneral.inf.ed.ac.uk/register "
	elog "(see the REGISTER file for more information)"
}
