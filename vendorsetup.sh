caf_devices=('rolex')

function lunch_devices() {
    add_lunch_combo wave_${device}-userdebug
}

for device in ${caf_devices[@]}; do
    lunch_devices
done
