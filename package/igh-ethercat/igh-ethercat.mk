################################################################################
#
# igh-ethercat
#
################################################################################

IGH_ETHERCAT_VERSION = 1.5.2
IGH_ETHERCAT_SITE = http://etherlab.org/download/ethercat
IGH_ETHERCAT_SOURCE = ethercat-$(IGH_ETHERCAT_VERSION).tar.bz2
IGH_ETHERCAT_LICENSE = GPLv2 (IgH EtherCAT master), LGPLv2.1 (libraries)
IGH_ETHERCAT_LICENSE_FILES = COPYING COPYING.LESSER

IGH_ETHERCAT_INSTALL_STAGING = YES

IGH_ETHERCAT_CONF_OPTS = \
	--with-linux-dir=$(LINUX_DIR) --enable-generic

define IGH_ETHERCAT_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) DESTDIR=$(TARGET_DIR) install
	if [ -f $(@D)/examples/user/ec_user_example ] ; then \
		cp $(@D)/examples/user/ec_user_example $(TARGET_DIR)/usr/bin/ ; \
	fi
endef

IGH_ETHERCAT_CONF_OPTS += $(if $(BR2_PACKAGE_IGH_ETHERCAT_8139TOO),--enable-8139too,--disable-8139too)
IGH_ETHERCAT_CONF_OPTS += $(if $(BR2_PACKAGE_IGH_ETHERCAT_E100),--enable-e100,--disable-e100)
IGH_ETHERCAT_CONF_OPTS += $(if $(BR2_PACKAGE_IGH_ETHERCAT_E1000),--enable-e1000,--disable-e1000)
IGH_ETHERCAT_CONF_OPTS += $(if $(BR2_PACKAGE_IGH_ETHERCAT_E1000E),--enable-e1000e,--disable-e1000e)
IGH_ETHERCAT_CONF_OPTS += $(if $(BR2_PACKAGE_IGH_ETHERCAT_R8169),--enable-r8169,--disable-r8169)

$(eval $(kernel-module))
$(eval $(autotools-package))
