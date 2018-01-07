# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

POSTGRES_COMPAT=( 9.{3..6} 10 )
inherit eutils postgres-multi

DESCRIPTION="Geolocation using GeoIP for PostgreSQL"
HOMEPAGE="http://pgxn.org/dist/geoip/"
SRC_URI="http://api.pgxn.org/dist/${PN}/${PV}/${P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86 ppc64 ~arm ~arm64"
IUSE=""

DEPEND="${POSTGRES_DEP}"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/00-makefile-0.2.4.patch"

	postgres-multi_src_prepare
}

src_configure() { :; }
src_compile() { :; }

src_install() {
	postgres-multi_foreach emake DESTDIR="${D}" install

	dodoc README.md LICENSE
}
