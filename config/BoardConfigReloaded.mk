# Kernel
include vendor/reloaded/config/BoardConfigKernel.mk

# QCOM
ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/reloaded/config/BoardConfigQcom.mk
endif

# SEPolicy
ifeq ($(TARGET_COPY_OUT_VENDOR), vendor)
ifeq ($(BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE),)
TARGET_USES_PREBUILT_VENDOR_SEPOLICY ?= true
endif
endif

ifeq ($(TARGET_USES_PREBUILT_VENDOR_SEPOLICY), true)
SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += \
    vendor/reloaded/sepolicy/dynamic
else
BOARD_VENDOR_SEPOLICY_DIRS += \
    vendor/reloaded/sepolicy/dynamic
endif

SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += \
    vendor/reloaded/sepolicy/private

SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS += \
    vendor/reloaded/sepolicy/public

BOARD_VENDOR_SEPOLICY_DIRS += \
    vendor/reloaded/sepolicy/vendor

# Soong
include vendor/reloaded/config/BoardConfigSoong.mk
