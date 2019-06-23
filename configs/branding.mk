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
#     WAVE_VERSION
#     CAF_VERSION
#     PLATFORM_WAVE_VERSION_CODE
#     PLATFORM_WAVE_BUILD_NUMBER
#     PLATFORM_WAVE_MAINTENANCE_PATCH
#

ifndef WAVE_VERSION
  # This is the global wave version that determines our releases
  # in various types. The types are defined as Major, Minor, and Maintenance.
  # Example of this syntax:
  # Major: The first number indicates a major system upgrade
  # Minor: The second number indicates a minor system upgrade which
  #        may include system pacthes for improvements and small new features.
  # Maintenance: The third number indicates a maintenance system upgrade with
  #              small, but effective improvements throughout the system.
  WAVE_VERSION := 1.0
endif

ifndef PLATFORM_WAVE_VERSION_CODE
  # As part of the Wave platform, each Major system upgrade is released
  # under a specific codename. The indicates which codename for which
  # major system upgrade under the Wave platform.
  PLATFORM_WAVE_VERSION_CODE := Peppermint
endif

ifndef PLATFORM_WAVE_BUILD_NUMBER
  # As part of the Wave platform, the Wave platform build number is a
  # separate indication of our build id's, which help track what build
  # on what particular version of wave. This allows generation new packages
  # and specific makefiles when making multiple builds under the same version.
  # Example of this syntax:
  # WPBN: Wave Platform Build Number
  # P8102: First indicates the (PLATFORM_WAVE_VERSION_CODE) followed by the reversed year.
  # $(shell date -u +%d): Auto generated current day
  # $(shell date -u +%m): Auto generated current month
  # 646: Last 3 numbers are a reversed time code. Time codes are track from the current time
  #      the (PLATFORM_WAVE_MAINTENANCE_PATCH) get's updated and so on.
  PLATFORM_WAVE_BUILD_NUMBER := WPBN.P9102.$(shell date -u +%d).$(shell date -u +%m)001
endif

ifndef PLATFORM_WAVE_MAINTENANCE_PATCH
  # As part of the wave platform, we include maintenance patches which
  # ship with our (Minor + Maintenance) releases to indicate what level
  # of maintenance has been applied across devices and builds. This uses
  # the same logic as Android's security patch level, except it is updated
  # simultaneously and not on a monthly iteration.
  PLATFORM_WAVE_MAINTENANCE_PATCH := 2019-07-01
endif

ifndef WAVE_BUILDTYPE
  # We build unofficial by default
  WAVE_BUILDTYPE := unofficial
endif

ifndef CAF_VERSION
  # Current CAF vserion.
  CAF_VERSION := LA.UM.7.3.r1-07800-sdm845.0
endif

# Output target zip.
WAVE_TARGET_ZIP := wave_$(WAVE_BUILD)-$(WAVE_VERSION)-$(shell date -u +%Y%m%d)-$(WAVE_BUILDTYPE).zip
