# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

POSTGRES_COMPAT=( 9.{3..6} 10 )
inherit eutils postgres

DESCRIPTION="top-like console for Pgbouncer - PostgreSQL connection pooler"
HOMEPAGE="https://github.com/lesovsky/pgbconsole"
SRC_URI="https://github.com/lesovsky/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86 ppc64 arm arm64"
IUSE=""

DEPEND="
	${POSTGRES_DEP}
	sys-libs/ncurses:0=
"
RDEPEND="${DEPEND}"

REQUIRED_USE="${POSTGRES_REQ_USE}"


pkg_pretend() {
	postgres_check_slot
}

src_prepare() {
	has_version 'sys-libs/ncurses:0[tinfo(-)]' && \
		epatch "${FILESDIR}/00-ncurses-tinfo.patch"
}

src_compile() {
	emake USE_PGXS=1
}

src_install() {
	# the Makefile does not create the target directory
	mkdir -p "${D}usr/bin"
	emake USE_PGXS=1 DESTDIR="${D}" install

	dodoc README.md doc/Changelog
	doman doc/pgbconsole.1.gz
}
