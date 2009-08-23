# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

ECVS_SERVER="cvs.savannah.nongnu.org:/sources/http-emacs"
ECVS_MODULE="http-emacs"
ECVS_AUTH="pserver"
ECVS_CVS_COMPRESS="-z3"

inherit elisp eutils cvs

DESCRIPTION="Allows you to fetch, render and post html pages via Emacs"
HOMEPAGE="http://emacswiki.org/cgi-bin/wiki.pl?SimpleWikiEditMode"
SRC_URI=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ia64 ~amd64"
IUSE=""

S=${WORKDIR}/${ECVS_MODULE}

SITEFILE=50http-emacs-gentoo.el
