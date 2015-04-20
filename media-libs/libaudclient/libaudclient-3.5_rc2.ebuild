# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/audacious/audacious-3.4.1.ebuild,v 1.9 2014/01/28 14:09:59 ago Exp $

EAPI=5
inherit eutils

MY_P="${P/_/-}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Legacy D-Bus client library for Audacious Player"
HOMEPAGE="http://audacious-media-player.org/"
SRC_URI="http://distfiles.audacious-media-player.org/${MY_P}.tar.bz2"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux"

IUSE="chardet nls"

RDEPEND=">=dev-libs/dbus-glib-0.60
	>=dev-libs/glib-2.28
	!<media-sound/audacious-3.5"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_install() {
	default
	dodoc AUTHORS
}
