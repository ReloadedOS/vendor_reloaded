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

# Enable SIP+VoIP
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Android Beam
PRODUCT_COPY_FILES += \
    vendor/wave/configs/permissions/android.software.nfc.beam.xml:system/etc/permissions/android.software.nfc.beam.xml

# Include support for GApps backup
PRODUCT_COPY_FILES += \
    vendor/wave/prebuilt/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/wave/prebuilt/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/wave/prebuilt/bin/50-backuptool.sh:system/addon.d/50-backuptool.sh

ifeq ($(AB_OTA_UPDATER),true)
PRODUCT_COPY_FILES += \
    vendor/wave/prebuilt/bin/backuptool_ab.sh:system/bin/backuptool_ab.sh \
    vendor/wave/prebuilt/bin/backuptool_ab.functions:system/bin/backuptool_ab.functions \
    vendor/wave/prebuilt/bin/backuptool_postinstall.sh:system/bin/backuptool_postinstall.sh
endif

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

# Bluetooth Audio (A2DP)
PRODUCT_PACKAGES += libbthost_if

# Include explicitly to work around GMS issues
PRODUCT_PACKAGES += libprotobuf-cpp-full

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

#SeLinux
PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

ifeq ($(TARGET_BUILD_VARIANT),eng)
# Disable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=0
else
# Enable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

PRODUCT_PACKAGES += \
    adb_root

# Sounds
include vendor/wave/configs/pixel2-audio_prebuilt.mk

# Branding stuffs
include vendor/wave/configs/branding.mk

# Bootanimation
include vendor/wave/configs/bootanimation.mk

# Disable qmi EAP-SIM security
DISABLE_EAP_PROXY := true

# Dex optimization
USE_DEX2OAT_DEBUG := false
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false
PRODUCT_ALWAYS_PREOPT_EXTRACTED_APK := true
PRODUCT_DEXPREOPT_SPEED_APPS += \
    Launcher3QuickStep \
    Settings \
    SystemUI

# Fix Google Dialer
PRODUCT_COPY_FILES +=  \
    vendor/wave/prebuilt/etc/sysconfig/dialer_experience.xml:system/etc/sysconfig/dialer_experience.xml

# SystemUI plugins
PRODUCT_PACKAGES += \
    QuickAccessWallet

PRODUCT_GMS_CLIENTID_BASE ?= android-google
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
    ro.com.google.clientidbase.am=$(PRODUCT_GMS_CLIENTID_BASE)
    ro.com.google.clientidbase.gmm=$(PRODUCT_GMS_CLIENTID_BASE)
    ro.com.google.clientidbase.ms=$(PRODUCT_GMS_CLIENTID_BASE)
    ro.com.google.clientidbase.yt=$(PRODUCT_GMS_CLIENTID_BASE)

# WaveOS Widget
PRODUCT_PACKAGES += \
    WaveWidget

# Blurs
PRODUCT_SYSTEM_EXT_PROPERTIES += \
    ro.sf.blurs_are_expensive=1 \
    ro.surface_flinger.supports_background_blur=1

# GApps
ifneq ($(VANILLA_BUILD),true)
$(warning Building with gapps)
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
endif

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.face.moto_unlock_service=$(TARGET_FACE_UNLOCK_SUPPORTED)

# Accents
PRODUCT_PACKAGES += \
    AccentColoriOSBlueOverlay \
    AccentColorPixelBlueOverlay

# Fonts
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,vendor/wave/prebuilt/fonts/,$(TARGET_COPY_OUT_PRODUCT)/fonts) \
    $(call find-copy-subdir-files,*,vendor/wave/prebuilt/fonts-system/,$(TARGET_COPY_OUT_SYSTEM)/fonts) \
    vendor/wave/prebuilt/etc/fonts_customization.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/fonts_customization.xml

PRODUCT_PACKAGES += \
    FontGoogleSansLatoOverlay \
    FontInterOverlay \
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
