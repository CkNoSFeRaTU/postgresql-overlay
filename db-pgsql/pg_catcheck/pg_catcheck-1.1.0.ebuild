# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

POSTGRES_COMPAT=( 9.{3..6} 10 )
POSTGRES_USEDEP="static-libs" # needed because of #571046
inherit eutils postgres-multi

DESCRIPTION="Tool for diagnosing PostgreSQL system catalog corruption"
HOMEPAGE="https://github.com/EnterpriseDB/pg_catcheck"
SRC_URI="https://github.com/EnterpriseDB/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86 ppc64 ~arm ~arm64"
IUSE=""

RDEPEND="
	${POSTGRES_DEP}
"
DEPEND="
	${DEPEND}
"

src_prepare() {
  epatch "${FILESDIR}/00-makefile-1.1.0.patch"

  postgres-multi_src_prepare
}

src_install() {
  postgres-multi_src_install

  dodoc README.md LICENSE
}
