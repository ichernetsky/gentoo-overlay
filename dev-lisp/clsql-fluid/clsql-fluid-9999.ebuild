# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit common-lisp-2 eutils multilib git

DESCRIPTION="CLSQL based on fluids, or per-thread connections."
HOMEPAGE="http://common-lisp.net/project/clsql-fluid/"
EGIT_REPO_URI="git://repo.or.cz/clsql/s11.git"
EGIT_BRANCH="fluid-pools"
EGIT_TREE="fluid-pools"

LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc postgres mysql sqlite sqlite3 odbc"

DEPEND="mysql? ( virtual/mysql )"
RDEPEND="${DEPEND}
	!dev-lisp/cl-sql
	!dev-lisp/clsql
	dev-lisp/md5
	>=dev-lisp/uffi-1.5.7
	postgres? ( dev-db/postgresql-base )
	sqlite? ( dev-db/sqlite:0 )
	sqlite3? ( dev-db/sqlite:3 )
	odbc? ( dev-db/unixODBC )"

src_prepare() {
	sed -i "s,/usr/lib,/usr/$(get_libdir),g" "${S}"/clsql-{mysql,uffi}.asd
	sed -i 's,"usr" "lib","usr" "'$(get_libdir)'",g' "${S}"/clsql-{mysql,uffi}.asd
}

src_compile() {
	make -C uffi || die "Cannot build UFFI helper library"
	if use mysql; then
		make -C db-mysql || die "Cannot build foreign glue to libmysql"
	fi
}

install_clsql_pkg() {
	cd "${S}"
	common-lisp-install db-${1}/*.lisp clsql-${1}.asd
	common-lisp-symlink-asdf clsql-${1}
	if [ -f db-${1}/clsql_${1}.so ]; then
		exeinto /usr/$(get_libdir)/clsql ; doexe db-${1}/clsql_${1}.so
	fi
}

src_install() {
	common-lisp-install clsql.asd clsql-fluid.asd sql/*.lisp clsql-tests.asd tests
	common-lisp-symlink-asdf clsql clsql-fluid clsql-tests

	common-lisp-install uffi/*.lisp clsql-uffi.asd
	common-lisp-symlink-asdf clsql-uffi
	exeinto /usr/$(get_libdir)/clsql ; doexe uffi/clsql_uffi.so

	install_clsql_pkg postgresql-socket
	use postgres && install_clsql_pkg postgresql
	for dbtype in mysql odbc sqlite sqlite3; do
		use ${dbtype} && install_clsql_pkg ${dbtype}
	done
	# TODO: figure out the dependencies
	install_clsql_pkg aodbc
	install_clsql_pkg db2
	install_clsql_pkg oracle

	dodoc BUGS CONTRIBUTORS ChangeLog INSTALL LATEST-TEST-RESULTS NEWS README TODO
	use doc && dodoc doc/clsql.pdf
	tar xfz doc/html.tar.gz -C "${T}" && dohtml "${T}"/html/*
	docinto examples && dodoc examples/*
	docinto notes && dodoc notes/*

	dodir /etc
	cat > "${D}"/etc/clsql-init.lisp <<EOF
(clsql:push-library-path #p"/usr/$(get_libdir)/")
(clsql:push-library-path #p"/usr/$(get_libdir)/clsql/")
EOF
}
