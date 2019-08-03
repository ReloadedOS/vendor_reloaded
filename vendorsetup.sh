caf_devices=('rolex' 'oneplus3' 'A6020')

for device in ${caf_devices[@]}; do
    add_lunch_combo wave_$device-userdebug
done

# SDClang Environment Variables
export SDCLANG_AE_CONFIG=vendor/wave/sdclang/sdclangAE.json
export SDCLANG_CONFIG=vendor/wave/sdclang/sdclang.json
export SDCLANG_SA_ENABLED=false
