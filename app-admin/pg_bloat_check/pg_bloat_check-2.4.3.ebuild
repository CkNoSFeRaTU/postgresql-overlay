# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )
inherit eutils python-single-r1

DESCRIPTION="Bloat check script for PostgreSQL"
HOMEPAGE="https://github.com/keithf4/pg_bloat_check"
SRC_URI="https://github.com/keithf4/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="PostgreSQL"
SLOT="0"
KEYWORDS="amd64 x86 ppc64 arm arm64"
IUSE=""

DEPEND=""
RDEPEND="
	${PYTHON_DEPS}
	dev-python/psycopg[${PYTHON_USEDEP}]
"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

src_install() {
	newbin pg_bloat_check.py pg_bloat_check

	python_fix_shebang "${ED}usr/bin/pg_bloat_check"

	dodoc CHANGELOG LICENSE	README.md
}
