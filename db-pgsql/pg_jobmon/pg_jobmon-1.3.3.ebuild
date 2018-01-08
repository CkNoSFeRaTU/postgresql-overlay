# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

POSTGRES_COMPAT=( 9.{3..6} 10 )
inherit eutils postgres-multi

DESCRIPTION="Job logging and monitoring extension for PostgreSQL"
HOMEPAGE="https://github.com/omniti-labs/pg_jobmon"
SRC_URI="https://github.com/omniti-labs/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86 ppc64 ~arm ~arm64"
IUSE=""

DEPEND="
	${POSTGRES_DEP}
"

RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/00-makefile-1.3.3.patch"

	postgres-multi_src_prepare
}

src_compile() { :; }

src_install() {
	postgres-multi_src_install

	dodoc README.md CHANGELOG doc/pg_jobmon.md
}
