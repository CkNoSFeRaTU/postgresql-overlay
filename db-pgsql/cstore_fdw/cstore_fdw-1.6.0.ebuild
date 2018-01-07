# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

POSTGRES_COMPAT=( 9.{3..6} 10 )
inherit eutils postgres-multi

DESCRIPTION="Columnar store extension for PostgreSQL"
HOMEPAGE="http://citusdata.github.io/cstore_fdw/"
SRC_URI="https://github.com/citusdata/${PN}/archive/v${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86 ppc64 ~arm ~arm64"
IUSE=""

DEPEND="
    ${POSTGRES_DEP}
	dev-libs/protobuf-c
"
RDEPEND="${DEPEND}"

src_prepare() {
  epatch "${FILESDIR}/00-makefile-1.6.0.patch"

  postgres-multi_src_prepare
}

src_compile() {
  postgres-multi_foreach emake
}

src_install() {
  postgres-multi_foreach emake DESTDIR="${D}" install
  

  dodoc README.md LICENSE
}
