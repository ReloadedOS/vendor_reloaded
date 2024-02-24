# Kernel
include vendor/reloaded/config/BoardConfigKernel.mk

# QCOM
ifneq ($(TARGET_EXCLUDES_QC_COMMON),true)
include device/qcom/common/BoardConfigQcom.mk
endif

# Dex2oat
ifeq ($(TARGET_CPU_VARIANT),cortex-a510)
    DEX2OAT_TARGET_CPU_VARIANT := cortex-a76
    DEX2OAT_TARGET_CPU_VARIANT_RUNTIME := cortex-a76
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
