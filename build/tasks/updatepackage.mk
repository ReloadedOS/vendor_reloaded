# Copyright (C) 2017 Unlegacy-Android
# Copyright (C) 2017 The LineageOS Project
# Copyright (C) 2018 CarbonROM
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

include vendor/reloaded/build/core/colors.mk

RELOADED_TARGET_UPDATEPACKAGE := $(PRODUCT_OUT)/$(RELOADED_VERSION)-img.zip

MD5 := prebuilts/build-tools/path/$(HOST_PREBUILT_TAG)/md5sum

.PHONY: updatepackage
updatepackage: $(INTERNAL_UPDATE_PACKAGE_TARGET)
	@echo "ReloadedOS Fastboot package"
	$(hide) mv $(INTERNAL_UPDATE_PACKAGE_TARGET) $(RELOADED_TARGET_UPDATEPACKAGE)
	$(hide) $(MD5) $(RELOADED_TARGET_UPDATEPACKAGE) > $(RELOADED_TARGET_UPDATEPACKAGE).md5sum
	@echo ""
	@echo -e ${CL_LBL}"═══════════════════════════════════════════════════════════════════"${CL_RST}
	@echo -e ${CL_LBL}"                                                                   "${CL_RST}
	@echo -e ${CL_LBL}"                                                                   "${CL_RST}
	@echo -e ${CL_LBL}" ██████╗ ███████╗██╗      ██████╗  █████╗ ██████╗ ███████╗██████╗  "${CL_RST}
	@echo -e ${CL_LBL}" ██╔══██╗██╔════╝██║     ██╔═══██╗██╔══██╗██╔══██╗██╔════╝██╔══██╗ "${CL_RST}
	@echo -e ${CL_LBL}" ██████╔╝█████╗  ██║     ██║   ██║███████║██║  ██║█████╗  ██║  ██║ "${CL_RST}
	@echo -e ${CL_LBL}" ██╔══██╗██╔══╝  ██║     ██║   ██║██╔══██║██║  ██║██╔══╝  ██║  ██║ "${CL_RST}
	@echo -e ${CL_LBL}" ██║  ██║███████╗███████╗╚██████╔╝██║  ██║██████╔╝███████╗██████╔╝ "${CL_RST}
	@echo -e ${CL_LBL}" ╚═╝  ╚═╝╚══════╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═════╝ ╚══════╝╚═════╝  "${CL_RST}
	@echo -e ${CL_LBL}"                                                                   "${CL_RST}
	@echo ""
	@echo -e ${CL_YLW}"═══════════════════════════════════════════════════════════════════"${CL_RST}
	@echo -e ${CL_CYN}"Fastboot zip:   "${CL_MAG} $(RELOADED_VERSION)-img.zip ${CL_RST}
	@echo -e ${CL_CYN}"Package folder: "${CL_MAG} $(PRODUCT_OUT) ${CL_RST}
	@echo -e ${CL_CYN}"Package md5:    "${CL_MAG} $(shell cat $(RELOADED_TARGET_UPDATEPACKAGE).md5sum | awk '{print $$1}') ${CL_RST}
	@echo -e ${CL_CYN}"Package size:   "${CL_MAG} $(shell du -h $(RELOADED_TARGET_UPDATEPACKAGE) | awk '{print $$1}') ${CL_RST}
	@echo -e ${CL_YLW}"═══════════════════════════════════════════════════════════════════"${CL_RST}
	@echo -e ""

.PHONY: updatepackage
