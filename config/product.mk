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

# WaveOS branding
$(call inherit-product, vendor/wave/config/branding.mk)

# Properties
$(call inherit-product, vendor/wave/config/properties.mk)

# Overlays
# TODO: Convert to RRO
PRODUCT_PACKAGE_OVERLAYS += vendor/wave/overlay

# Boot animation
TARGET_BOOT_ANIMATION_RES := $(strip $(TARGET_BOOT_ANIMATION_RES))

ifneq ($(filter $(TARGET_BOOT_ANIMATION_RES),720 1080 1440),)
     PRODUCT_COPY_FILES += vendor/wave/prebuilt/media/bootanimation/$(TARGET_BOOT_ANIMATION_RES).zip:$(TARGET_COPY_OUT_PRODUCT)/media/bootanimation.zip
else
     $(warning Invalid bootanimation resolution: $(TARGET_BOOT_ANIMATION_RES). Defaulting to AOSP bootanimation.)
     $(warning Set TARGET_BOOT_ANIMATION_RES to 480/720/1080/1440 to use wave bootanimation)
endif

# APN list
PRODUCT_COPY_FILES += \
    vendor/wave/prebuilt/etc/apns-conf.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/apns-conf.xml

# Dex optimization
USE_DEX2OAT_DEBUG := false
WITH_DEXPREOPT_DEBUG_INFO := false
DONT_DEXPREOPT_PREBUILTS := true
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false
PRODUCT_ALWAYS_PREOPT_EXTRACTED_APK := true
PRODUCT_DEX_PREOPT_DEFAULT_COMPILER_FILTER := everything

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
    $(call find-copy-subdir-files,*,vendor/wave/prebuilt/fonts/,$(TARGET_COPY_OUT_PRODUCT)/fonts) \
    $(call find-copy-subdir-files,*,vendor/wave/prebuilt/fonts-system/,$(TARGET_COPY_OUT_SYSTEM)/fonts) \
    vendor/wave/prebuilt/etc/fonts_customization.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/fonts_customization.xml

PRODUCT_PACKAGES += \
    FontGoogleSansLatoOverlay \
    FontGoogleSansRobotoOverlay \
    FontInterOverlay \
    FontManropeOverlay \
    FontOnePlusSansOverlay

$(call inherit-product-if-exists, external/google-fonts/lato/fonts.mk)
endif

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

# Themes
PRODUCT_PACKAGES += \
    ThemePicker
