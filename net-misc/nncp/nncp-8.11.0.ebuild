# Copyright 2019-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd

DESCRIPTION="Utilities for securely store-and-forwarding files, mail and commands"
HOMEPAGE="http://www.nncpgo.org/"
SRC_URI="http://www.nncpgo.org/download/${P}.tar.xz"
LICENSE="GPL-3"
SLOT="0"

KEYWORDS="~amd64"
IUSE="systemd yggdrasil"
RESTRICT="strip"

export GOFLAGS="-buildmode=pie"
export GO111MODULE=auto
export EGO_PN="go.cypherpunks.ru/nncp/v8"

BDEPEND="${BDEPEND}
	app-arch/unzip
	>=dev-lang/go-1.20
"

RDEPEND="${RDEPEND}
	acct-user/nncp
"

src_prepare() {

	touch nncp.hjson
	eapply_user

}

src_configure() {

	if ! use yggdrasil; then
		export GO_CFLAGS='-tags noyggdrasil '
	fi

}

src_compile() {

	SENDMAIL=${SENDMAIL:-/usr/sbin/sendmail}
	CFGPATH=${CFGPATH:-$PREFIX/etc/nncp/nncp.hjson}
	SPOOLPATH=${SPOOLPATH:-/var/spool/nncp}
	LOGPATH=${LOGPATH:-/var/spool/nncp/log}

	cd src
	MOD=$(go list -mod=vendor)
	GO_LDFLAGS=''
	GO_LDFLAGS="${GO_LDFLAGS} -X ${MOD}.DefaultCfgPath=${CFGPATH}"
	GO_LDFLAGS="${GO_LDFLAGS} -X ${MOD}.DefaultSendmailPath=${SENDMAIL}"
	GO_LDFLAGS="${GO_LDFLAGS} -X ${MOD}.DefaultSpoolPath=${SPOOLPATH}"
	GO_LDFLAGS="${GO_LDFLAGS} -X ${MOD}.DefaultLogPath=${LOGPATH}"
	for CMD in $(cat ../bin/cmd.list); do
		go build -mod=vendor -o ../bin/${CMD} ${GOFLAGS} -ldflags "${GO_LDFLAGS}" ./cmd/${CMD}
	done
	go build -mod=vendor -o ../bin/hjson-cli ${GOFLAGS} github.com/hjson/hjson-go/v4/hjson-cli

}

src_install() {

	for CMD in $(cat bin/cmd.list); do
		dobin bin/${CMD}
	done

	insinto /etc/nncp
	doins -r nncp.hjson

	dodoc AUTHORS NEWS NEWS.RU README README.RU THANKS
	doinfo doc/nncp.info

	if use systemd; then
		for UNIT in nncp-caller nncp-daemon nncp-toss; do
			systemd_newunit "${FILESDIR}/${UNIT}.service" "${UNIT}.service"
		done
	fi

}
