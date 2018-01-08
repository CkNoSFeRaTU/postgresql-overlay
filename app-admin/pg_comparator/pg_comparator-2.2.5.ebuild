# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

POSTGRES_COMPAT=( 9.{3..6} 10 )
inherit eutils postgres-multi

DESCRIPTION="Efficient table content comparison and synchronization for PostgreSQL and MySQL"
HOMEPAGE="https://github.com/koordinates/pg_comparator"
SRC_URI="https://github.com/koordinates/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86 ppc64 ~arm ~arm64"
IUSE="mysql"

DEPEND="
	${POSTGRES_DEP}
	mysql? ( virtual/mysql )
"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/00-makefile-2.2.5.patch"

	postgres-multi_src_prepare
}

src_compile() {
	postgres-multi_src_compile

	# build the perlscript documantation
	emake pg_comparator.1
	emake pg_comparator.html

	# for mysql
	if use mysql ; then
		einfo "building mysql plugins"
		emake mysql_casts.so
		emake mysql_checksum.so
	fi
}

src_install() {
	postgres-multi_foreach emake DESTDIR="${D}" install

	dobin pg_comparator

	if use mysql ; then
		einfo "installing mysql plugins"
		emake DESTDIR="${D}" mysql_install
	fi
	
	dodoc README.pg_comparator README.pgc_casts README.pgc_checksum README.xor_aggregate \
		INSTALL LICENSE pg_comparator.html
	doman pg_comparator.1

}
