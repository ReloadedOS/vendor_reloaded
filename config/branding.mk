# Copyright 2022 ReloadedOS
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

RELOADED_VERSION_BASE := 13.0
RELOADED_BUILD_TYPE ?= UNOFFICIAL
RELOADED_BUILD_VARIANT := GAPPS

ifeq ($(RELOADED_BUILD_TYPE),OFFICIAL)
  OFFICIAL_DEVICES = $(shell cat vendor/reloaded/reloaded.devices)
    ifneq ($(filter $(TARGET_PRODUCT), $(OFFICIAL_DEVICES)),$(TARGET_PRODUCT))
      RELOADED_BUILD_TYPE := UNOFFICIAL
      $(warning Device is not official "$(TARGET_PRODUCT)")
    endif
endif

ifeq ($(VANILLA_BUILD),true)
RELOADED_BUILD_VARIANT := VANILLA
endif

# Example: Reloaded-13.0-lisa-OFFICIAL-20221001-GAPPS
RELOADED_VERSION := Reloaded-$(RELOADED_VERSION_BASE)-$(TARGET_PRODUCT)-$(RELOADED_BUILD_TYPE)-$(shell date +%Y%m%d)-$(RELOADED_BUILD_VARIANT)

PRODUCT_SYSTEM_EXT_PROPERTIES += \
    ro.reloaded.version=$(RELOADED_VERSION_BASE) \
    ro.reloaded.build_type=$(RELOADED_BUILD_TYPE) \
    ro.reloaded.build_variant=$(RELOADED_BUILD_VARIANT)
