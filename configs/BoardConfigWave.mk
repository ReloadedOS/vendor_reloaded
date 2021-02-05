# Kernel
include vendor/wave/configs/BoardConfigKernel.mk

# QCOM
ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/wave/configs/BoardConfigQcom.mk
endif

# SEPolicy
BOARD_PLAT_PRIVATE_SEPOLICY_DIR += \
    vendor/wave/sepolicy/private

BOARD_PLAT_PUBLIC_SEPOLICY_DIR += \
    vendor/wave/sepolicy/public

# Soong
include vendor/wave/configs/BoardConfigSoong.mk
