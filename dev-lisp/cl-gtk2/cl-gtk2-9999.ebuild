# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit common-lisp-2 eutils git

EAPI="2"

DESCRIPTION="A CommonLisp interface to the Gtk+"
HOMEPAGE="http://common-lisp.net/project/cl-gtk2/"
EGIT_REPO_URI="git://github.com/dmitryvk/cl-gtk2.git"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-lisp/cffi-0.10.4
	>=dev-lisp/iterate-1.4.3
	>=dev-lisp/closer-mop-0.55
	>=dev-lisp/trivial-garbage-0.18
	>=dev-lisp/bordeaux-threads-0.6.0
	>=x11-libs/gtk+-2.16:2
	>=x11-libs/gtkglext-1.2.0
	dev-lisp/cl-opengl"

CLSYSTEMS="gtk/cl-gtk2-gtk gdk/cl-gtk2-gdk glib/cl-gtk2-glib gtk-glext/cl-gtk2-gtkglext"

S="${WORKDIR}"/${PN}

src_install() {
	common-lisp-install gdk gtk glib gtk-glext
	common-lisp-symlink-asdf
}