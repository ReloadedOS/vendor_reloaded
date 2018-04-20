caf_devices=('rolex')

function lunch_devices() {
    add_lunch_combo wave_${device}-userdebug
}

for device in ${caf_devices[@]}; do
    lunch_devices
done

# SDClang Environment Variables
export SDCLANG_AE_CONFIG=vendor/wave/sdclang/sdclangAE.json
export SDCLANG_CONFIG=vendor/wave/sdclang/sdclang.json
export SDCLANG_SA_ENABLED=false
