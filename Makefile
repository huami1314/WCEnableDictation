SYSROOT = $(THEOS)/sdks/iPhoneOS16.5.sdk
TARGET = iphone:clang:16.5:14.0
ARCHS = arm64 arm64e

#export THEOS=/Users/huami/theos
#export THEOS_PACKAGE_SCHEME=roothide

ifeq ($(SCHEME),roothide)
    export THEOS_PACKAGE_SCHEME = roothide
else ifeq ($(SCHEME),rootless)
    export THEOS_PACKAGE_SCHEME = rootless
endif

export DEBUG = 0

INSTALL_TARGET_PROCESSES = WeChat

PACKAGE_VERSION = 1.0.0
TWEAK_NAME = WCEnableDictation


WCEnableDictation_CFLAGS = -fobjc-arc
WCEnableDictation_FILES = Tweak.x

include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk

THEOS_DEVICE_IP = 192.168.31.222
THEOS_DEVICE_PORT = 22

clean::
	@echo -e "\033[31m==>\033[0m Cleaning packages…"
	@rm -rf packages/*

after-package::
	@if [ "$(THEOS_PACKAGE_SCHEME)" = "roothide" ]; then \
	echo -e "\033[31m==>\033[0m Installing package to device…"; \
	DEB_FILE=$$(ls -t packages/*.deb | head -1); \
	PACKAGE_NAME=$$(basename "$$DEB_FILE" | cut -d'_' -f1); \
	ssh root@$(THEOS_DEVICE_IP) "rm -rf /tmp/$${PACKAGE_NAME}.deb"; \
	scp "$$DEB_FILE" root@$(THEOS_DEVICE_IP):/tmp/$${PACKAGE_NAME}.deb; \
	ssh root@$(THEOS_DEVICE_IP) "dpkg -i --force-overwrite /tmp/$${PACKAGE_NAME}.deb && rm -f /tmp/$${PACKAGE_NAME}.deb"; \
	fi