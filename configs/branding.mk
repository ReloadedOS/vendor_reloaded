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

# WaveOS 4.x - Android 11
PLATFORM_WAVE_VERSION := 4.7
PLATFORM_WAVE_FLAVOUR := Rasmalai

# Output target zip name
ifneq ($(VANILLA_BUILD),true)
WAVE_TARGET_ZIP := WaveOS_$(WAVE_BUILD)-R-v$(PLATFORM_WAVE_VERSION)-$(shell date -u +%Y%m%d-%H%M)-UNOFFICIAL.zip
else
WAVE_TARGET_ZIP := WaveOS_$(WAVE_BUILD)-R-v$(PLATFORM_WAVE_VERSION)-$(shell date -u +%Y%m%d-%H%M)-UNOFFICIAL-vanilla.zip
endif
