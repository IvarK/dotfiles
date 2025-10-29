for bus in $(ddcutil detect | grep "I2C bus:" | awk -F'/dev/i2c-' '{print $2}' | awk '{print $1}'); do
  ddcutil --bus=$bus setvcp 10 100
done