# Copyright (C) 2019 Wave-OS
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

# WaveOS signed builds
$(call inherit-product-if-exists, vendor/wave-stonks/build/target/product/wave.mk)

# Branding stuffs
include vendor/wave/configs/branding.mk

# Bootanimation
include vendor/wave/configs/bootanimation.mk

# Android Beam
PRODUCT_COPY_FILES += \
    vendor/wave/configs/permissions/android.software.nfc.beam.xml:system/etc/permissions/android.software.nfc.beam.xml

# Copy wave specific init file
PRODUCT_COPY_FILES += \
    vendor/wave/prebuilt/etc/init.wave.rc:system/etc/init/init.wave.rc

# Include vendor overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/wave/overlay

# Include hostapd configuration
PRODUCT_COPY_FILES += \
    vendor/wave/prebuilt/etc/hostapd/hostapd_default.conf:system/etc/hostapd/hostapd_default.conf \
    vendor/wave/prebuilt/etc/hostapd/hostapd.deny:system/etc/hostapd/hostapd.deny \
    vendor/wave/prebuilt/etc/hostapd/hostapd.accept:system/etc/hostapd/hostapd.accept

# World APN list
PRODUCT_COPY_FILES += \
    vendor/wave/prebuilt/etc/apns-conf.xml:system/etc/apns-conf.xml

# Build some apps
PRODUCT_PACKAGES += \
    ViaBrowser \
    ExactCalculator \
    SimpleGallery

# Include support for additional filesystems
PRODUCT_PACKAGES += \
    e2fsck \
    mke2fs \
    tune2fs \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat \
    ntfsfix \
    ntfs-3g

# RCS Service
PRODUCT_PACKAGES += \
    rcscommon \
    rcscommon.xml \
    rcsservice \
    rcs_service_aidl \
    rcs_service_aidl.xml \
    rcs_service_aidl_static \
    rcs_service_api \
    rcs_service_api.xml

# ADB
PRODUCT_PACKAGES += \
    adb_root

# Dex optimization
USE_DEX2OAT_DEBUG := false
WITH_DEXPREOPT_DEBUG_INFO := false
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false
PRODUCT_ALWAYS_PREOPT_EXTRACTED_APK := true
PRODUCT_DEX_PREOPT_DEFAULT_COMPILER_FILTER := everything

# Fix Google Dialer
PRODUCT_COPY_FILES +=  \
    vendor/wave/prebuilt/etc/sysconfig/dialer_experience.xml:system/etc/sysconfig/dialer_experience.xml

# SystemUI plugins
PRODUCT_PACKAGES += \
    QuickAccessWallet

# WaveOS Widget
PRODUCT_PACKAGES += \
    WaveWidget

# GApps
ifneq ($(VANILLA_BUILD),true)
$(call inherit-product-if-exists, vendor/google/gms/config.mk)
else
$(warning Building vanilla - without gapps)
endif

# Config
PRODUCT_PACKAGES += \
    SimpleDeviceConfig \

# Charger mode images
PRODUCT_PACKAGES += \
    charger_res_images

ifneq ($(TARGET_USES_AOSP_CHARGER),true)
PRODUCT_PACKAGES += \
    product_charger_res_images
endif

# GCAM Go
ifneq ($(TARGET_OPT_OUT_GCAM_GO),true)
PRODUCT_PACKAGES += \
    GCamGOPrebuilt
endif

# Immersive Navigation
PRODUCT_PACKAGES += \
    ImmersiveNavigationOverlay

# Face Unlock
TARGET_FACE_UNLOCK_SUPPORTED ?= true

ifneq ($(TARGET_FACE_UNLOCK_SUPPORTED), false)
PRODUCT_PACKAGES += \
    FaceUnlockService

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.face_unlock_service.enabled=$(TARGET_FACE_UNLOCK_SUPPORTED)
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.biometrics.face.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.biometrics.face.xml
endif

# Accents
PRODUCT_PACKAGES += \
    AccentColoriOSBlueOverlay \
    AccentColorHadalZoneOverlay \
    AccentColorLostInForestOverlay \
    AccentColorMagentaOverlay \
    AccentColorPixelBlueOverlay \
    AccentColorPurpleHeatOverlay \
    AccentColorRedOverlay \
    AccentColorRoseOverlay \
    AccentColorScooterOverlay \
    AccentColorSlateOverlay \
    AccentColorSuperNovaOverlay \
    AccentColorTealOverlay \
    AccentColorTorchRedOverlay

# Fonts
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,vendor/wave/prebuilt/fonts/,$(TARGET_COPY_OUT_PRODUCT)/fonts) \
    $(call find-copy-subdir-files,*,vendor/wave/prebuilt/fonts-system/,$(TARGET_COPY_OUT_SYSTEM)/fonts) \
    vendor/wave/prebuilt/etc/fonts_customization.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/fonts_customization.xml

PRODUCT_PACKAGES += \
    FontGoogleSansLatoOverlay \
    FontInterOverlay \
    FontManropeOverlay \
    FontOnePlusSansOverlay

$(call inherit-product-if-exists, external/google-fonts/lato/fonts.mk)

# Flatten APEXs for performance
OVERRIDE_TARGET_FLATTEN_APEX := true
# This needs to be specified explicitly to override ro.apex.updatable=true from
# prebuilt vendors, as init reads /product/build.prop after /vendor/build.prop
PRODUCT_PRODUCT_PROPERTIES += ro.apex.updatable=false

# Extra tools
PRODUCT_PACKAGES += \
    7z \
    bash \
    bzip2 \
    curl \
    getcap \
    htop \
    lib7z \
    libsepol \
    nano \
    pigz \
    setcap \
    unrar \
    vim \
    zip

# Long Screenshot
PRODUCT_PACKAGES += \
    StitchImage

# Fix for missing aeabi symbols on old blobs
PRODUCT_COPY_FILES += \
    prebuilts/vndk/v29/arm64/arch-arm-armv8-a/shared/vndk-sp/libcompiler_rt.so:vendor/lib/libcompiler_rt.so \
    prebuilts/vndk/v29/arm64/arch-arm64-armv8-a/shared/vndk-sp/libcompiler_rt.so:vendor/lib64/libcompiler_rt.so

# Pixel Sounds
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,vendor/wave/prebuilt/media/audio/,$(TARGET_COPY_OUT_PRODUCT)/media/audio)

PRODUCT_PRODUCT_PROPERTIES += \
    ro.config.ringtone=The_big_adventure.ogg \
    ro.config.notification_sound=End_note.ogg \
    ro.config.alarm_alert=Bright_morning.ogg

# Themes
PRODUCT_PACKAGES += \
    ThemePicker \
    WaveThemesStub \
    WaveBalls

# Default permissions
PRODUCT_COPY_FILES += \
    vendor/wave/configs/permissions/default-permissions-wave.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/default-permissions/default-permissions-wave.xml

# Use 64-bit dex2oat for better dexopt time
ifeq ($(TARGET_SUPPORTS_64_BIT_APPS), true)
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.dex2oat64.enabled=true
endif

# Treble
# Enable ALLOW_MISSING_DEPENDENCIES on Vendorless Builds
ifeq ($(BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE),)
  ALLOW_MISSING_DEPENDENCIES := true
endif

# DocumentsUI
PRODUCT_PACKAGES += \
    PixelDocumentsUIGoogleOverlay

# Cutout control overlays
PRODUCT_PACKAGES += \
    HideCutout \
    StatusBarStock
