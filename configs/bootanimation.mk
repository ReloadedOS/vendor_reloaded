#
# Copyright (C) 2020 Wave-OS
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

# Get Wave specific boot animation
TARGET_BOOT_ANIMATION_RES := $(strip $(TARGET_BOOT_ANIMATION_RES))

ifneq ($(filter $(TARGET_BOOT_ANIMATION_RES),720 1080 1440),)
     PRODUCT_COPY_FILES += vendor/wave/prebuilt/media/bootanimation/$(TARGET_BOOT_ANIMATION_RES).zip:$(TARGET_COPY_OUT_SYSTEM)/media/bootanimation.zip
else
     $(warning Invalid bootanimation resolution: $(TARGET_BOOT_ANIMATION_RES). Defaulting to AOSP bootanimation.)
     $(warning Define TARGET_BOOT_ANIMATION_RES to 480/720/1080/1440 to use wave bootanimation)
endif
