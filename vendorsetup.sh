caf_devices=('rolex' 'oneplus3' 'A6020')

for device in ${caf_devices[@]}; do
    add_lunch_combo wave_$device-userdebug
done
