inherit eutils

DESCRIPTION="multi-protocol distributed load testing tool"
HOMEPAGE="http://tsung.erlang-projects.org/"
SRC_URI="http://tsung.erlang-projects.org/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="gnuplot"

RDEPEND="dev-lang/erlang
	gnuplot? (
		sci-visualization/gnuplot
		dev-lang/perl
	)"
DEPEND="${RDEPEND}"

src_install() {
	make install \
		DESTDIR="${D}" \
		bindir="${D}"/usr/bin \
		libdir="${D}"/usr/lib \
		datadir="${D}"/usr/share \
		|| die "make install failed"

	if use gnuplot; then
		elog 'enable the png use flag for gnuplot to generate'
		elog 'nice graphs in the html reports of tsung'
	fi
}

pkg_postinst() {
	elog 'The default configuration file is ~/.tsung/tsung.xml'
	elog 'There are several sample files in /usr/share/doc/tsung/examples)'
	elog 'Log files are saved in ~/.tsung/log/'
}
