# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils

DESCRIPTION="top for performance counters"
HOMEPAGE="http://tiptop.gforge.inria.fr/"
SRC_URI="http://${PN}.gforge.inria.fr/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-libs/ncurses
	dev-libs/libxml2"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-ncurses_tinfo.patch
}
