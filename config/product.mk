# Copyright (C) 2019 Wave-OS
#           (C) 2022 ReloadedOS
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Qualcomm Common configuration
ifneq ($(TARGET_EXCLUDES_QC_COMMON),true)
$(call inherit-product, device/qcom/common/common.mk)
endif

# SDClang
$(call inherit-product, vendor/qcom/sdclang/config/SnapdragonClang.mk)

# ReloadedOS branding
$(call inherit-product, vendor/reloaded/config/branding.mk)

# Properties
$(call inherit-product, vendor/reloaded/config/properties.mk)

# Overlays
# TODO: Convert to RRO
PRODUCT_PACKAGE_OVERLAYS += vendor/reloaded/overlay

# Boot animation
PRODUCT_COPY_FILES += \
    vendor/reloaded/prebuilt/media/bootanimation.zip:$(TARGET_COPY_OUT_PRODUCT)/media/bootanimation.zip

# APN list
PRODUCT_COPY_FILES += \
    vendor/reloaded/prebuilt/etc/apns-conf.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/apns-conf.xml

# Dex optimization
USE_DEX2OAT_DEBUG := false
WITH_DEXPREOPT_DEBUG_INFO := false
DONT_DEXPREOPT_PREBUILTS := true
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false
PRODUCT_ALWAYS_PREOPT_EXTRACTED_APK := true
PRODUCT_DEX_PREOPT_DEFAULT_COMPILER_FILTER := everything

# Enable whole-program R8 Java optimizations for SystemUI and system_server,
# but also allow explicit overriding for testing and development.
SYSTEM_OPTIMIZE_JAVA ?= true
SYSTEMUI_OPTIMIZE_JAVA ?= true

# Google stuff
ifneq ($(VANILLA_BUILD),true)
# GMS
ifneq ($(wildcard vendor/partner_gms/products/gms.mk),)
$(call inherit-product, vendor/partner_gms/products/gms.mk)
else
$(call inherit-product, vendor/google/gms/config.mk)
endif
# Modules
ifeq ($(TARGET_FLATTEN_APEX), false)
$(call inherit-product-if-exists, vendor/google/modules/build/mainline_modules_s.mk)
else
$(call inherit-product-if-exists, vendor/google/modules/build/mainline_modules_s_flatten_apex.mk)
endif
# Pixel
$(call inherit-product, vendor/google/pixel/config.mk)
else
$(warning Building vanilla - without gapps)
endif

# Charger mode images
PRODUCT_PACKAGES += \
    charger_res_images

# Camera
PRODUCT_PACKAGES += \
    Camera

# Immersive Navigation
PRODUCT_PACKAGES += \
    ImmersiveNavigationOverlay

# Fonts
ifeq (0,1) # Not including them for now
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,vendor/reloaded/prebuilt/fonts/,$(TARGET_COPY_OUT_PRODUCT)/fonts) \
    $(call find-copy-subdir-files,*,vendor/reloaded/prebuilt/fonts-system/,$(TARGET_COPY_OUT_SYSTEM)/fonts) \
    vendor/reloaded/prebuilt/etc/fonts_customization.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/fonts_customization.xml

PRODUCT_PACKAGES += \
    FontGoogleSansLatoOverlay \
    FontGoogleSansRobotoOverlay \
    FontInterOverlay \
    FontManropeOverlay \
    FontOnePlusSansOverlay

$(call inherit-product-if-exists, external/google-fonts/lato/fonts.mk)
endif

# Themes
PRODUCT_PACKAGES += \
    ThemePicker

# Include support for additional filesystems
PRODUCT_PACKAGES += \
    e2fsck \
    mke2fs \
    tune2fs \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat

# Telephony - AOSP
PRODUCT_PACKAGES += \
    messaging \
    Stk

# Telephony - CLO
PRODUCT_PACKAGES += \
    extphonelib \
    extphonelib-product \
    extphonelib.xml \
    extphonelib_product.xml \
    ims-ext-common \
    ims_ext_common.xml \
    qti-telephony-hidl-wrapper \
    qti-telephony-hidl-wrapper-prd \
    qti_telephony_hidl_wrapper.xml \
    qti_telephony_hidl_wrapper_prd.xml \
    qti-telephony-utils \
    qti-telephony-utils-prd \
    qti_telephony_utils.xml \
    qti_telephony_utils_prd.xml \
    tcmiface \
    telephony-ext

PRODUCT_BOOT_JARS += \
    tcmiface \
    telephony-ext

# QTI vendor framework detection
PRODUCT_PACKAGES += \
    libqti_vndfwk_detect \
    libqti_vndfwk_detect.vendor \
    libvndfwk_detect_jni.qti \
    libvndfwk_detect_jni.qti.vendor

# Wallique
PRODUCT_PACKAGES += \
   Wallique

# Repainter (kdrag0n)
PRODUCT_PACKAGES += \
    RepainterServicePriv

# Icon packs
PRODUCT_PACKAGES += \
    IconPackCircularAndroidOverlay \
    IconPackCircularLauncherOverlay \
    IconPackCircularSettingsOverlay \
    IconPackCircularSystemUIOverlay \
    IconPackCircularThemePickerOverlay \
    IconPackVictorAndroidOverlay \
    IconPackVictorLauncherOverlay \
    IconPackVictorSettingsOverlay \
    IconPackVictorSystemUIOverlay \
    IconPackVictorThemePickerOverlay \
    IconPackSamAndroidOverlay \
    IconPackSamLauncherOverlay \
    IconPackSamSettingsOverlay \
    IconPackSamSystemUIOverlay \
    IconPackSamThemePickerOverlay \
    IconPackKaiAndroidOverlay \
    IconPackKaiLauncherOverlay \
    IconPackKaiSettingsOverlay \
    IconPackKaiSystemUIOverlay \
    IconPackKaiThemePickerOverlay \
    IconPackFilledAndroidOverlay \
    IconPackFilledLauncherOverlay \
    IconPackFilledSettingsOverlay \
    IconPackFilledSystemUIOverlay \
    IconPackFilledThemePickerOverlay \
    IconPackRoundedAndroidOverlay \
    IconPackRoundedLauncherOverlay \
    IconPackRoundedSettingsOverlay \
    IconPackRoundedSystemUIOverlay \
    IconPackRoundedThemePickerOverlay
