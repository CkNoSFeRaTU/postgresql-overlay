# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

POSTGRES_COMPAT=( 9.{3..6} 10 )
inherit eutils postgres-multi perl-functions

DESCRIPTION="DML logging tool for PostgreSQL"
HOMEPAGE="http://pgxn.org/dist/cyanaudit"
SRC_URI="http://api.pgxn.org/dist/${PN}/${PV}/${P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86 ppc64 ~arm ~arm64"
IUSE="+tools"


DEPEND="
	${POSTGRES_DEP}
"
RDEPEND="
	${DEPEND}
	tools? ( dev-perl/DBD-Pg )
"

src_prepare() {
	epatch "${FILESDIR}/00-makefile-1.0.2.patch"

	postgres-multi_src_prepare
}

src_install() {
    postgres-multi_foreach emake DESTDIR="${D}" install

    if use tools ; then
        perl_domodule tools/Cyanaudit.pm
        dobin tools/${PN}_dump.pl
        dobin tools/${PN}_log_rotate.pl
        dobin tools/${PN}_restore.pl
        dobin tools/${PN}_tablespace_fix.sh
    fi

    dodoc README.md LICENSE doc/cyanaudit{,_changelog,_upgrade_howto}.md
}
