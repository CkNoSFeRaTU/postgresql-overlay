# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION="PostgreSQL utility for creating a small, sample database from a larger one"
HOMEPAGE="https://github.com/mla/pg_sample"
SRC_URI="https://github.com/mla/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 x86 ppc64 arm arm64"
IUSE=""

DEPEND=""
RDEPEND="
	dev-lang/perl
	dev-perl/DBD-Pg
	dev-db/postgresql
"

src_install() {
	dobin pg_sample
	dodoc README.md
}
