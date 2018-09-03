# Copyright (C) 2010 Wave-OS
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

# -----------------------------------------------------------------
# Wave OTA update package

# Build system colors
ifneq ($(BUILD_WITH_COLORS),0)
    include vendor/wave/build/core/colors.mk
endif

WAVE_TARGET_PACKAGE := $(PRODUCT_OUT)/$(WAVE_TARGET_ZIP)
WAVE_TARGET_PACKAGE_FOLDER := $(PRODUCT_OUT)

.PHONY: bacon
bacon: $(INTERNAL_OTA_PACKAGE_TARGET)
	$(hide) mv $(INTERNAL_OTA_PACKAGE_TARGET) $(WAVE_TARGET_PACKAGE)
	$(hide) $(MD5SUM) $(WAVE_TARGET_PACKAGE) | sed "s|$(PRODUCT_OUT)/||" > $(WAVE_TARGET_PACKAGE).md5sum
	@echo -e ""
	@echo -e ${CL_CYN}"==========================================================================="${CL_RST}
	@echo -e ""
	@echo -e ${CL_LRD}" :::       ::: "${CL_LBL}"     :::     "${CL_LGR}" :::     ::: "${CL_LYL}" :::::::::: "${CL_RST}
	@echo -e ${CL_LRD}" :+:       :+: "${CL_LBL}"   :+: :+:   "${CL_LGR}" :+:     :+: "${CL_LYL}" :+:        "${CL_RST}
	@echo -e ${CL_LRD}" +:+       +:+ "${CL_LBL}"  +:+   +:+  "${CL_LGR}" +:+     +:+ "${CL_LYL}" +:+        "${CL_RST}
	@echo -e ${CL_LRD}" +#+  +:+  +#+ "${CL_LBL}" +#++:++#++: "${CL_LGR}" +#+     +:+ "${CL_LYL}" +#++:++#   "${CL_RST}
	@echo -e ${CL_LRD}" +#+ +#+#+ +#+ "${CL_LBL}" +#+     +#+ "${CL_LGR}"  +#+   +#+  "${CL_LYL}" +#+        "${CL_RST}
	@echo -e ${CL_LRD}"  #+#+# #+#+#  "${CL_LBL}" #+#     #+# "${CL_LGR}"   #+#+#+#   "${CL_LYL}" #+#        "${CL_RST}
	@echo -e ${CL_LRD}"   ###   ###   "${CL_LBL}" ###     ### "${CL_LGR}"     ###     "${CL_LYL}" ########## "${CL_RST}
	@echo -e ""
	@echo -e ${CL_CYN}"=============================-Package complete-============================"${CL_RST}
	@echo -e ${CL_CYN}"Folder : "${CL_MAG} $(WAVE_TARGET_PACKAGE_FOLDER)${CL_RST}
	@echo -e ${CL_CYN}"ZipName: "${CL_MAG} $(WAVE_TARGET_ZIP)${CL_RST}
	@echo -e ${CL_CYN}"MD5    : "${CL_MAG}" $(shell cat $(WAVE_TARGET_PACKAGE).md5sum | awk '{print $$1}')"${CL_RST}
	@echo -e ${CL_CYN}"Size   : "${CL_MAG}" $(shell du -hs $(WAVE_TARGET_PACKAGE) | awk '{print $$1}')"${CL_RST}
	@echo -e ${CL_CYN}"==========================================================================="${CL_RST}
	@echo -e ""
