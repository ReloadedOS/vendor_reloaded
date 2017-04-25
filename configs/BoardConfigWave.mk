# Kernel
include vendor/wave/configs/BoardConfigKernel.mk

# QCOM
ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/wave/configs/BoardConfigQcom.mk
endif

# SEPolicy
ifeq ($(TARGET_COPY_OUT_VENDOR), vendor)
ifeq ($(BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE),)
TARGET_USES_PREBUILT_VENDOR_SEPOLICY ?= true
endif
endif

ifeq ($(TARGET_USES_PREBUILT_VENDOR_SEPOLICY), true)
BOARD_PLAT_PRIVATE_SEPOLICY_DIR += \
    vendor/wave/sepolicy/dynamic
else
BOARD_VENDOR_SEPOLICY_DIRS += \
    vendor/wave/sepolicy/dynamic
endif

BOARD_PLAT_PRIVATE_SEPOLICY_DIR += \
    vendor/wave/sepolicy/private

BOARD_PLAT_PUBLIC_SEPOLICY_DIR += \
    vendor/wave/sepolicy/public

BOARD_VENDOR_SEPOLICY_DIRS += \
    vendor/wave/sepolicy/vendor

# Soong
include vendor/wave/configs/BoardConfigSoong.mk
