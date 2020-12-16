# Kernel
include vendor/wave/configs/BoardConfigKernel.mk

# QCOM
ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/wave/configs/BoardConfigQcom.mk
endif

# Soong
include vendor/wave/configs/BoardConfigSoong.mk
