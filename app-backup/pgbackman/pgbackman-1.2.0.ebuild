# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_{6,7} )
inherit eutils distutils-r1 user

DESCRIPTION="PostgreSQL backup manager"
HOMEPAGE="http://www.pgbackman.org/"
SRC_URI="https://github.com/rafaelma/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc64 ~arm ~arm64"
IUSE="logrotate zabbix"

DEPEND="
	${PYTHON_DEPS}
	dev-python/psycopg:2[${PYTHON_USEDEP}]
	logrotate? ( app-admin/logrotate )
	zabbix? ( net-analyzer/zabbix )
"
RDEPEND="
	${DEPEND}
	dev-db/postgresql
	virtual/cron
	sys-process/at
"

pkg_setup() {
	enewgroup pgbackman
	enewuser pgbackman -1 /bin/bash /var/lib/pgbackman pgbackman
}

src_install() {
	# we do first a default installation and then fix the image
	distutils-r1_src_install

	# remove the redhat specific init script
	rm -rf ${D}/etc/init.d

	# add our custom initscript
	newinitd ${FILESDIR}/pgbackman.initd pgbackman

	# remove the logrotate script unless logrotate is enabled
	if ! use logrotate ; then
		rm -rf ${D}/etc/logrotate.d
	fi

	# remove the zabbix autodiscovery features unless the zabbix useflag is enabled
	if ! use zabbix ; then
		find ${D} -name pgbackman_zabbix_autodiscovery -delete
	fi
}
