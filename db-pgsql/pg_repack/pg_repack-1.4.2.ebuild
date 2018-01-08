# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

POSTGRES_COMPAT=( 9.{3..6} 10 )
POSTGRES_USEDEP="static-libs" # needed because of #571046
inherit eutils postgres-multi

DESCRIPTION="Reorganize tables in PostgreSQL databases without any locks"
HOMEPAGE="https://reorg.github.io/pg_repack/"
SRC_URI="http://api.pgxn.org/dist/${PN}/${PV}/${P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86 ppc64 ~arm ~arm64"
IUSE=""

DEPEND="
	${POSTGRES_DEP}
"
RDEPEND="${DEPEND}"

src_install() {
	postgres-multi_foreach emake DESTDIR="${D}" install

	dodoc README.rst COPYRIGHT
}

pkg_postinst() {
	eselect postgresql update
}
