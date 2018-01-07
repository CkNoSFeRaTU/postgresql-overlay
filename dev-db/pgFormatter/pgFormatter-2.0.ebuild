# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit perl-module

DESCRIPTION="A PostgreSQL SQL syntax beautifier"
HOMEPAGE="https://github.com/darold/pgformatter"
SRC_URI="https://github.com/darold/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86 ppc64 arm arm64"
IUSE=""