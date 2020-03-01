#
# Copyright (C) 2015-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v3.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=adguard
PKG_VERSION:=0.100.9
PKG_RELEASE:=1

ifeq ($(ARCH),mipsel)
	AdGuard_ARCH:=mipsle
endif
ifeq ($(ARCH),mips)
	AdGuard_ARCH:=mips
endif
ifeq ($(ARCH),i386)
	AdGuard_ARCH:=386
endif
ifeq ($(ARCH),x86_64)
	AdGuard_ARCH:=amd64
endif
ifeq ($(ARCH),arm)
	AdGuard_ARCH:=arm
endif
ifeq ($(ARCH),aarch64)
	AdGuard_ARCH:=arm64
endif

PKG_LICENSE:=Apache-2.0

PKG_SOURCE_URL:=https://github.com/AdguardTeam/AdGuardHome/releases/download/v$(PKG_VERSION)
PKG_SOURCE:=AdGuardHome_linux_$(AdGuard_ARCH).tar.gz

ifeq ($(BOARD),bcm53xx)
    PKG_SOURCE_URL:=https://static.adguard.com/adguardhome/beta
    PKG_SOURCE:=AdGuardHome_linux_armv5.tar.gz
endif

PKG_BUILD_DIR:=$(BUILD_DIR)/AdGuardHome
PKG_HASH:=skip

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=net
	CATEGORY:=Network
	TITLE:=AdGuard Home
	URL:=https://github.com/AdguardTeam/AdGuardHome/releases
endef

define Package/$(PKG_NAME)/description
powerful network-wide ads & trackers blocking DNS server.
endef

define Build/Prepare
	$(PKG_UNPACK)
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin/AdGuardHome
	$(INSTALL_DIR) $(1)/usr/bin/AdGuardHome/data
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/AdGuardHome $(1)/usr/bin/AdGuardHome/AdGuardHome
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
