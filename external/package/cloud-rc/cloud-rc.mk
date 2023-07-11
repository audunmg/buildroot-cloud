################################################################################
#
# cloud-rc
#
################################################################################

#CLOUD_RC_VERSION = 0.7.0
#CLOUD_RC_SITE = https://github.com/dehydrated-io/dehydrated/releases/download/v$(DEHYDRATED_VERSION)

#CLOUD_RC_LICENSE = MIT
#CLOUD_RC_LICENSE_FILES = LICENSE

define CLOUD_RC_INSTALL_TARGET_CMDS
        $(INSTALL) -D -m 0755 $(CLOUD_RC_PKGDIR)/files/rc.cloud-functions $(TARGET_DIR)/usr/share/cloud-rc/rc.cloud-functions

        $(INSTALL) -D -m 0755 $(CLOUD_RC_PKGDIR)/files/rc.cloud-prenetwork $(TARGET_DIR)/etc/init.d/S01cloud-rc-prenetwork
        $(INSTALL) -D -m 0755 $(CLOUD_RC_PKGDIR)/files/rc.cloud-setup $(TARGET_DIR)/etc/init.d/S41cloud-rc-setup
        $(INSTALL) -D -m 0755 $(CLOUD_RC_PKGDIR)/files/rc.cloud-final $(TARGET_DIR)/etc/init.d/S50cloud-rc-final

endef

$(eval $(generic-package))

