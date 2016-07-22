# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit common-lisp-3 git-2

DESCRIPTION="A set of CFFI bindings for libcurses (ncurses), a GUI-like console"
HOMEPAGE="http://www.cliki.net/cl-charms"
EGIT_REPO_URI="https://github.com/HiTECNOLOGYs/cl-charms.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lisp/alexandria
	dev-lisp/cffi
	sys-libs/ncurses"
