# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

CABAL_FEATURES="bin lib profile haddock"
inherit haskell-cabal

DESCRIPTION="Colourise Haskell code."
HOMEPAGE="http://www.cs.york.ac.uk/fp/darcs/hscolour/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.8
	dev-haskell/cabal"

src_install() {
	cabal_src_install
	if use doc; then
		dohtml index.html hscolour.css
		dodoc README
	fi
}
