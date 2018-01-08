# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

POSTGRES_COMPAT=( 9.{3..6} 10 )
inherit eutils postgres-multi java-utils-2

DESCRIPTION="PostgreSQL Foreign Data Wrapper (FDW) for the hdfs"
HOMEPAGE="https://github.com/EnterpriseDB/hdfs_fdw"
SRC_URI="https://github.com/EnterpriseDB/${PN}/archive/v${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86 ppc64 ~arm ~arm64"
IUSE=""

RDEPEND="
	${POSTGRES_DEP}
	dev-libs/libxml2
	virtual/jdk:1.8
"
DEPEND="
	${RDEPEND}
	dev-java/java-config
"

src_prepare() {
	epatch "${FILESDIR}/00-makefile-2.0.3.patch"
	epatch "${FILESDIR}/01-makefile-libhive-2.0.3.patch"

	postgres-multi_src_prepare
}

src_configure() { :; }
src_compile() {
	export JDK_INCLUDE="$(java-config -O)/include"

	einfo "building hive c bindings"
	postgres-multi_foreach emake -C libhive

	# jdbc binding library
	einfo "building hive java bindings"
	pushd libhive/jdbc >/dev/null
	ejavac MsgBuf.java
	ejavac HiveJdbcClient.java
	jar cf HiveJdbcClient-1.0.jar *.class
	popd >/dev/null

	einfo "building pgsql extension"
	postgres-multi_foreach emake USE_PGXS=1
}

src_install() {
	postgres-multi_foreach _src_install_libhive
	postgres-multi_foreach emake DESTDIR="${D}" USE_PGXS=1 install

	dodoc README.md LICENSE CONTRIBUTING.md
}


_src_install_libhive() {
	PGX_INSTALL_DIR="$(${PG_CONFIG} --pkglibdir)"

	dodir ${PGX_INSTALL_DIR}

	emake -C libhive DESTDIR="${D}" INSTALL_DIR="${D}/${PGX_INSTALL_DIR}" install

	insinto "${PGX_INSTALL_DIR}"
	doins ${S}/libhive/jdbc/HiveJdbcClient-1.0.jar
}
