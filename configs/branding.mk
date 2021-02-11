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
#     PLATFORM_WAVE_VERSION_CODE
#

ifndef PLATFORM_WAVE_VERSION
  # This is the global wave version that determines our releases
  # in various types. The types are defined as Major, Minor, and Maintenance.
  # Example of this syntax:
  # Major: The first number indicates a major system upgrade
  # Minor: The second number indicates a minor system upgrade which
  #        may include system pacthes for improvements and small new features.
  # Maintenance: The third number indicates a maintenance system upgrade with
  #              small, but effective improvements throughout the system.
  PLATFORM_WAVE_VERSION := 4.0
endif

ifndef PLATFORM_WAVE_VERSION_CODE
  # As part of the Wave platform, each Major system upgrade is released
  # under a specific codename. The indicates which codename for which
  # major system upgrade under the Wave platform.
  PLATFORM_WAVE_VERSION_CODE := Rasmalai
endif

# Output target zip name
WAVE_TARGET_ZIP := WaveOS_$(WAVE_BUILD)-R-v$(PLATFORM_WAVE_VERSION)-$(shell date -u +%Y%m%d-%H%M)-UNOFFICIAL.zip
