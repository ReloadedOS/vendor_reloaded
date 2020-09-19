PATH_OVERRIDE_SOONG := $(shell echo $(TOOLS_PATH_OVERRIDE))

# Add variables that we wish to make available to soong here.
EXPORT_TO_SOONG := \
    KERNEL_ARCH \
    KERNEL_BUILD_OUT_PREFIX \
    KERNEL_CROSS_COMPILE \
    KERNEL_MAKE_CMD \
    KERNEL_MAKE_FLAGS \
    PATH_OVERRIDE_SOONG \
    TARGET_KERNEL_CONFIG \
    TARGET_KERNEL_SOURCE

# Setup SOONG_CONFIG_* vars to export the vars listed above.
# Documentation here:
# https://github.com/LineageOS/android_build_soong/commit/8328367c44085b948c003116c0ed74a047237a69

SOONG_CONFIG_NAMESPACES += waveVarsPlugin

SOONG_CONFIG_waveVarsPlugin :=

define addVar
  SOONG_CONFIG_waveVarsPlugin += $(1)
  SOONG_CONFIG_waveVarsPlugin_$(1) := $$(subst ",\",$$($1))
endef

$(foreach v,$(EXPORT_TO_SOONG),$(eval $(call addVar,$(v))))

SOONG_CONFIG_NAMESPACES += waveGlobalVars
SOONG_CONFIG_waveGlobalVars += \
    additional_gralloc_10_usage_bits \
    target_init_vendor_lib \
    target_ld_shim_libs \
    target_process_sdk_version_override

SOONG_CONFIG_NAMESPACES += waveQcomVars
SOONG_CONFIG_waveQcomVars += \
    supports_extended_compress_format \
    uses_pre_uplink_features_netmgrd \
    uses_qti_camera_device

# Only create soong_namespace var if dealing with UM platforms to avoid breaking build for all other platforms
ifneq ($(filter $(UM_PLATFORMS),$(TARGET_BOARD_PLATFORM)),)
SOONG_CONFIG_waveQcomVars += \
    qcom_soong_namespace
endif

# Soong bool variables
SOONG_CONFIG_waveQcomVars_supports_extended_compress_format := $(AUDIO_FEATURE_ENABLED_EXTENDED_COMPRESS_FORMAT)
SOONG_CONFIG_waveQcomVars_uses_pre_uplink_features_netmgrd := $(TARGET_USES_PRE_UPLINK_FEATURES_NETMGRD)
SOONG_CONFIG_waveQcomVars_uses_qti_camera_device := $(TARGET_USES_QTI_CAMERA_DEVICE)

# Set default values
TARGET_INIT_VENDOR_LIB ?= vendor_init

# Soong value variables
SOONG_CONFIG_waveGlobalVars_additional_gralloc_10_usage_bits := $(TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS)
SOONG_CONFIG_waveGlobalVars_target_init_vendor_lib := $(TARGET_INIT_VENDOR_LIB)
SOONG_CONFIG_waveGlobalVars_target_ld_shim_libs := $(subst $(space),:,$(TARGET_LD_SHIM_LIBS))
SOONG_CONFIG_waveGlobalVars_target_process_sdk_version_override := $(TARGET_PROCESS_SDK_VERSION_OVERRIDE)
ifneq ($(filter $(UM_PLATFORMS),$(TARGET_BOARD_PLATFORM)),)
SOONG_CONFIG_waveQcomVars_qcom_soong_namespace := $(QCOM_SOONG_NAMESPACE)
endif

ifneq ($(TARGET_USE_QTI_BT_STACK),true)
PRODUCT_SOONG_NAMESPACES += packages/apps/Bluetooth
endif #TARGET_USE_QTI_BT_STACK
