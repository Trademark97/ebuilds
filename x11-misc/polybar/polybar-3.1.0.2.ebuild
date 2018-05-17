# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit cmake-utils git-r3

DESCRIPTION="A fast and easy-to-use tool for creating status bars."
HOMEPAGE="https://github.com/jaagr/polybar"
EGIT_REPO_URI="https://github.com/Trademark97/polybar.git"
EGIT_CLONE_TYPE="shallow"
EGIT_COMMIT="${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="alsa i3wm mpd github +network"
RDEPEND="
	x11-libs/libxcb
	dev-lang/python:2.7
	x11-base/xcb-proto
	x11-libs/xcb-util-wm
	x11-libs/xcb-util-image

	alsa? ( media-libs/alsa-lib )
	i3wm? ( dev-libs/jsoncpp
		|| ( x11-wm/i3 x11-wm/i3-gaps )
		)
	mpd? ( media-libs/libmpdclient )
	github? ( net-misc/curl )
	network? ( net-wireless/wireless-tools )
"
DEPEND="${RDEPEND}"
#PATCHES[0]="${FILESDIR}/no-werror.patch"

CMAKE_BUILD_TYPE=Release

src_configure() {
	local mycmakeargs=(
		-DPYTHON_EXECUTABLE:FILEPATH=/usr/bin/python2
		-DENABLE_ALSA="$(usex alsa)"
		-DENABLE_MPD="$(usex mpd)"
		-DENABLE_NETWORK="$(usex network)"
		-DENABLE_I3="$(usex i3wm)"
		-DENABLE_CURL="$(usex github)"
	)
	cmake-utils_src_configure
}
