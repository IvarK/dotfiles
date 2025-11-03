# This actually just controls contrast :D

state="$1"

if [[ "$state" != "idle" && "$state" != "active" ]]; then
  echo "Error: State must be 'idle' or 'active'"
  exit 1
fi

if [[ "$state" == "idle" ]]; then
  ddcutil setvcp -d 1 12 0
  ddcutil setvcp -d 2 12 0
  ddcutil setvcp -d 3 12 0
else
  ddcutil setvcp -d 1 12 80
  ddcutil setvcp -d 2 12 80
  ddcutil setvcp -d 3 12 80
fi