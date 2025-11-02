state="$1"

if [[ "$state" != "off" && "$state" != "on" ]]; then
  echo "Error: State must be 'off' or 'on'"
  exit 1
fi

if [[ "$state" == "off" ]]; then
  ddcutil setvcp -d 1 0xD6 4
  ddcutil setvcp -d 2 0xD6 4
  ddcutil setvcp -d 3 0xD6 4
else
  ddcutil setvcp -d 1 0xD6 1
  ddcutil setvcp -d 2 0xD6 1
  ddcutil setvcp -d 3 0xD6 1
fi