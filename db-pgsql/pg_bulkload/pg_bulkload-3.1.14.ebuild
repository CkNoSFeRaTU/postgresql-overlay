# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

POSTGRES_COMPAT=( 9.{3..6} 10 )
POSTGRES_USEDEP="static-libs" # needed because of #571046
inherit eutils postgres-multi

DESCRIPTION="High speed data loading utility for PostgreSQL"
HOMEPAGE="https://ossc-db.github.io/pg_bulkload"
SRC_URI="https://github.com/ossc-db/${PN}/archive/VERSION${PV//./_}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86 ppc64 ~arm ~arm64"
IUSE=""

RDEPEND="
    ${POSTGRES_DEP}
    dev-libs/openssl
    sys-libs/readline
"
DEPEND="
    ${DEPEND}
"
S="${WORKDIR}/${PN}-VERSION${PV//./_}"
src_prepare() {
  epatch "${FILESDIR}/00-makefiles-3.1.14.patch"

  postgres-multi_src_prepare
}

src_compile() {
    postgres-multi_foreach emake USE_PGXS=1
}

src_install() {
  postgres-multi_src_install

  dodoc README.md COPYRIGHT
  dodoc -r docs/*
}
