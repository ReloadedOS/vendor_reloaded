#!/bin/sh

WAVE_QCOM_HARDWARE=$(get_build_var TARGET_HARDWARE_QCOM)

# The organization
WAVE_GIT="https://github.com/Wave-Project"

# Required hals
HALS="audio media display"

for hal in ${HALS}; do
  echo -e "${color_success}Setting up $hal hal: ${WAVE_QCOM_HARDWARE}"${color_reset}
  echo -e "${color_failed}Deleting hal folder if exists"${color_reset}
  rm -rf hardware/qcom/"$hal"
  echo -e "${color_success}Cloning required hal"${color_reset}
  git clone "$WAVE_GIT"/hardware_qcom_"$hal" -b p-"$WAVE_QCOM_HARDWARE" hardware/qcom/"$hal"
done
