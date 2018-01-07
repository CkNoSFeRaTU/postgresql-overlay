# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

POSTGRES_COMPAT=( 9.{3..6} 10 )
inherit eutils postgres-multi

DESCRIPTION="A table update logger for PostgreSQL"
HOMEPAGE="http://pgxn.org/dist/e-maj"
SRC_URI="http://api.pgxn.org/dist/${PN}/${PV}/${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86 ppc64 ~arm ~arm64"
IUSE=""

DEPEND="${POSTGRES_DEP}"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/00-makefile-2.2.1.patch"

	postgres-multi_src_prepare
}

src_install() {
	postgres-multi_foreach emake DESTDIR="${D}" install

	dodoc README.md sql/emaj_*.sql
}
