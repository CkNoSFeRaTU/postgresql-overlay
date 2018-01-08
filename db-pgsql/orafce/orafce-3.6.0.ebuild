# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

POSTGRES_COMPAT=( 9.{3..6} 10 )
inherit eutils postgres-multi

DESCRIPTION="Implementation of some Oracle functions into PostgreSQL"
HOMEPAGE="https://github.com/orafce/orafce"
SRC_URI="https://github.com/${PN}/${PN}/archive/VERSION_${PV//./_}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86 ppc64 ~arm ~arm64"
IUSE=""

RDEPEND="
	${POSTGRES_DEP}
	dev-libs/openssl
	virtual/krb5
"
DEPEND="
	${DEPEND}
	sys-devel/bison
	sys-devel/flex
"
S="${WORKDIR}/${PN}-VERSION_${PV//./_}"
src_prepare() {
  epatch "${FILESDIR}/00-makefile-3.6.0.patch"
  epatch "${FILESDIR}/orafce.control.patch"

  postgres-multi_src_prepare
}

src_install() {
  postgres-multi_src_install

  dodoc README.asciidoc COPYRIGHT.orafce INSTALL.orafce
  dodoc -r doc/*
}
