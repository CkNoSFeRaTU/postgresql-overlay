# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )
DISTUTILS_SINGLE_IMPL=1
inherit distutils-r1

POSTGRES_COMPAT=( 9.{3..6} 10 )
POSTGRES_USEDEP="python,${PYTHON_USEDEP}"
inherit eutils postgres-multi

DESCRIPTION="Multicorn Python bindings for Postgres 9.2+ FDW"
HOMEPAGE="https://multicorn.readthedocs.org/"
SRC_URI="http://api.pgxn.org/dist/${PN}/${PV}/${P}.zip"

LICENSE="PostgreSQL"
SLOT="0"
KEYWORDS="amd64 x86 ppc64 ~arm ~arm64"
IUSE=""

DEPEND="
    ${POSTGRES_DEP}
    ${PYTHON_DEPS}
    dev-python/setuptools[${PYTHON_USEDEP}]
"

RDEPEND="${DEPEND}"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

src_prepare() {
    epatch "${FILESDIR}/00-makefile-1.3.4.patch"
    epatch "${FILESDIR}/01-setuptools-pgxs-1.3.4.patch"

    postgres-multi_src_prepare
}

src_compile() {
    postgres-multi_src_compile
}

src_install() {
    postgres-multi_src_install

    python_setup
    postgres-multi_forbest distutils-r1_python_install
    
    dodoc README.md
    dodoc -r doc/*
}