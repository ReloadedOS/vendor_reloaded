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

# Override undesired Google defaults
ADDITIONAL_BUILD_PROPERTIES += \
    ro.com.android.dateformat=dd-MM-yyyy \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.setupwizard.require_network=any \
    ro.setupwizard.mode=OPTIONAL \
    ro.opa.eligible_device=true \
    ro.storage_manager.enabled=true \
    setupwizard.theme=glif_v3_light

# WaveOS Branding
ADDITIONAL_BUILD_PROPERTIES += \
    ro.wave.version=$(PLATFORM_WAVE_VERSION) \
    ro.wave.flavour=$(PLATFORM_WAVE_FLAVOUR) \
    ro.wave.device=$(WAVE_BUILD)

ifeq ($(TARGET_BUILD_VARIANT),eng)
# Disable ADB authentication
ADDITIONAL_DEFAULT_PROPERTIES += ro.adb.secure=0
else
# Enable ADB authentication
ADDITIONAL_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

# GMS
PRODUCT_GMS_CLIENTID_BASE ?= android-google
ADDITIONAL_BUILD_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE) \
    ro.com.google.clientidbase.am=$(PRODUCT_GMS_CLIENTID_BASE) \
    ro.com.google.clientidbase.gmm=$(PRODUCT_GMS_CLIENTID_BASE) \
    ro.com.google.clientidbase.ms=$(PRODUCT_GMS_CLIENTID_BASE) \
    ro.com.google.clientidbase.yt=$(PRODUCT_GMS_CLIENTID_BASE)

# Blurs
ADDITIONAL_BUILD_PROPERTIES += \
    ro.sf.blurs_are_expensive=1 \
    ro.surface_flinger.supports_background_blur=1

# IORap
ADDITIONAL_BUILD_PROPERTIES += \
    iorapd.perfetto.enable=true \
    iorapd.readahead.enable=true \
    persist.device_config.runtime_native_boot.iorap_perfetto_enable=true \
    persist.device_config.runtime_native_boot.iorap_readahead_enable=true \
    ro.iorapd.enable=true

# Disable touch video heatmap to reduce latency, motion jitter, and CPU usage
# on supported devices with Deep Press input classifier HALs and models
ADDITIONAL_BUILD_PROPERTIES += \
    ro.input.video_enabled=false

# Disable extra StrictMode features on all non-engineering builds
ifneq ($(TARGET_BUILD_VARIANT),eng)
ADDITIONAL_BUILD_PROPERTIES += \
    persist.sys.strictmode.disable=true
endif
