# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit apache-module eutils

DESCRIPTION="mod_lisp2 is an Apache2 module to easily write web applications in Common Lisp"
HOMEPAGE="http://www.fractalconcept.com/asp/html/mod_lisp.html"
SRC_URI="mirror://gentoo/${P}.c"

LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
IUSE=""
SLOT="0"

# See apache-module.eclass for more information.
APACHE2_MOD_CONF="10_${PN}"
APACHE2_MOD_DEFINE="LISP"

need_apache2

src_unpack() {
		mkdir -p "${S}" || die "mkdir S failed"
		cp -f "${DISTDIR}/${P}.c" "${S}/${PN}.c" || die "source copy failed"
}
