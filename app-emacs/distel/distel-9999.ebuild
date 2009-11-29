# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit elisp eutils subversion

DESCRIPTION="Distributed Emacs Lisp for Erlang"
HOMEPAGE="http://fresh.homeunix.net/~luke/distel/"
ESVN_REPO_URI="http://distel.googlecode.com/svn/trunk/"

# "New BSD License" according to http://code.google.com/p/distel/
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND=">=dev-lang/erlang-11.2.5[emacs]"
RDEPEND="${DEPEND}"

SITEFILE="50${PN}-gentoo.el"

src_compile() {
	emake base info || die "emake failed"
	cd elisp
	elisp-compile *.el || die
}

src_install() {
	emake prefix="${D}"/usr \
		ELISP_DIR="${D}${SITELISP}/${PN}" install \
		|| die "emake install failed"
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
	doinfo doc/distel.info || die "doinfo failed"
	dohtml doc/distel/*.html || die "dohtml failed"
	dodoc AUTHORS ChangeLog NEWS README* || die "dodoc failed"
	if use doc; then
		dodoc doc/gorrie02distel.pdf || die "dodoc failed"
	fi
}
