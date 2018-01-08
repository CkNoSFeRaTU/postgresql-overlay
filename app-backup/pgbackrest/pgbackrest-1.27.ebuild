# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils perl-module

DESCRIPTION="Reliable PostgreSQL Backup & Restore"
HOMEPAGE="http://www.pgbackrest.org/"
SRC_URI="https://github.com/pgbackrest/${PN}/archive/release/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86 ppc64 ~arm ~arm64"
IUSE=""

DEPEND="
	virtual/perl-ExtUtils-MakeMaker
	dev-libs/openssl
"
RDEPEND="
	${DEPEND}
	dev-perl/IO-Socket-SSL
	dev-perl/DBD-Pg
	dev-perl/XML-LibXML
	dev-db/postgresql
"

S="${WORKDIR}/${PN}-release-${PV}"

src_prepare() {
	pushd libc >/dev/null
	perl-module_src_prepare
	popd >/dev/null
}

src_configure() {
	pushd libc >/dev/null
	perl-module_src_configure
	popd >/dev/null
}

src_compile() {
	pushd libc >/dev/null
	perl-module_src_compile
	popd >/dev/null
}

src_install() {
	perl_domodule -r lib/pgBackRest

	pushd libc >/dev/null
	perl-module_src_install
	popd >/dev/null

	dobin bin/pgbackrest

	keepdir /var/log/pgbackrest
	fowners postgres:postgres /var/log/pgbackrest

	keepdir /var/lib/pgbackrest
	fowners postgres:postgres /var/lib/pgbackrest

	keepdir /var/spool/pgbackrest
	fowners postgres:postgres /var/spool/pgbackrest

	insinto /etc
	doins ${FILESDIR}/pgbackrest.conf
	fowners postgres:postgres /etc/pgbackrest.conf

	dodoc LICENSE README.md
}
