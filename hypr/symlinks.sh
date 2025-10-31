#!/usr/bin/env bash
# usage: ./link.sh work   or   ./link.sh home

profile="$1"

if [[ "$profile" != "work" && "$profile" != "home" ]]; then
  echo "Error: profile must be 'work' or 'home'"
  exit 1
fi

dir="$(dirname "$(realpath "$0")")"

ln -sf "$dir/configs/$profile/hypridle.conf"     "$dir/hypridle.conf"
ln -sf "$dir/configs/$profile/monitors.conf"    "$dir/configs/monitors.conf"
ln -sf "$dir/configs/$profile/workspaces.conf"  "$dir/configs/workspaces.conf"
ln -sf "$dir/configs/$profile/other.conf"       "$dir/configs/other.conf"