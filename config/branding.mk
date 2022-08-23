# Copyright 2019 Wave-OS
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

#
# Handle various build version information.
#
# Guarantees that the following are defined:
#     PLATFORM_WAVE_VERSION
#     PLATFORM_WAVE_FLAVOUR
#

# WaveOS 5.x - Android 13
PLATFORM_WAVE_VERSION := 5.0-test1
PLATFORM_WAVE_FLAVOUR := Tangerine
PLATFORM_WAVE_FLAVOUR_ABBREV := T

# Example: WaveOS_lisa-T-v5.0-20220824-unofficial.zip
WAVE_TARGET_ZIP_NAME := WaveOS_$(TARGET_PRODUCT)-$(PLATFORM_WAVE_FLAVOUR_ABBREV)-v$(PLATFORM_WAVE_VERSION)-$(shell date +%Y%m%d)-unofficial
ifeq ($(VANILLA_BUILD),true)
WAVE_TARGET_ZIP_NAME := $(WAVE_TARGET_ZIP_NAME)-vanilla
endif

PRODUCT_SYSTEM_EXT_PROPERTIES += \
    ro.wave.version=$(PLATFORM_WAVE_VERSION) \
    ro.wave.flavour=$(PLATFORM_WAVE_FLAVOUR) \
    ro.wave.device=$(TARGET_PRODUCT)
