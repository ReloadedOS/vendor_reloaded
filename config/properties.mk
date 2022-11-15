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

ifeq ($(TARGET_BUILD_VARIANT),eng)
# Disable ADB authentication
PRODUCT_PRODUCT_PROPERTIES += ro.adb.secure=0
else
# Enable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

# GMS client id
ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

# GMS spoofing fingerprint
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.build.gms_fingerprint=google/angler/angler:6.0/MDB08L/2343525:user/release-keys

# Disable touch video heatmap to reduce latency, motion jitter, and CPU usage
# on supported devices with Deep Press input classifier HALs and models
PRODUCT_PRODUCT_PROPERTIES += \
    ro.input.video_enabled=false

# Disable extra StrictMode features on all non-engineering builds
ifneq ($(TARGET_BUILD_VARIANT),eng)
PRODUCT_SYSTEM_PROPERTIES += \
    persist.sys.strictmode.disable=true
endif

# Enable gesture navigation by default
PRODUCT_PRODUCT_PROPERTIES += \
    ro.boot.vendor.overlay.theme=com.android.internal.systemui.navbar.gestural

# Use 64-bit dex2oat for better dexopt time
ifeq ($(TARGET_SUPPORTS_64_BIT_APPS), true)
PRODUCT_SYSTEM_PROPERTIES += \
    dalvik.vm.dex2oat64.enabled=true
endif

# Disable blur on app-launch
PRODUCT_SYSTEM_EXT_PROPERTIES += \
    ro.launcher.blur.appLaunch=0

# Disable RescueParty due to high risk of data loss
PRODUCT_PRODUCT_PROPERTIES += \
    persist.sys.disable_rescue=true

# Enable one-handed mode
PRODUCT_PRODUCT_PROPERTIES += \
    ro.support_one_handed_mode=true

# Dexopt
PRODUCT_SYSTEM_PROPERTIES += \
    pm.dexopt.first-boot=quicken \
    pm.dexopt.bg-dexopt=everything

# Privileged app permissions
PRODUCT_PRODUCT_PROPERTIES += \
    ro.control_privapp_permissions=log
