# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

EGIT_REPO_URI="git://gitorious.org/geiser/mainline.git"
EGIT_BRANCH="master"

inherit elisp git

DESCRIPTION="Geiser is a generic Emacs/Scheme interaction mode"
HOMEPAGE="http://gitorious.org/geiser"
SRC_URI=""
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ia64 ~amd64"
IUSE=""

SITEFILE=70geiser-gentoo.el

src_configure() {
	./autogen.sh || die "autogen.sh failed"
	econf \
		--with-lispdir="usr/share/emacs/site-lisp/geiser"|| die "econf failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
	dodoc AUTHORS COPYING ChangeLog NEWS README
}