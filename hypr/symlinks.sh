#!/usr/bin/env bash
# usage: ./symlinks.sh work   or   ./symlinks.sh home

set -euo pipefail

profile="${1:-}"

if [[ "$profile" != "work" && "$profile" != "home" ]]; then
  echo "Error: profile must be 'work' or 'home'"
  exit 1
fi

dir="$(dirname "$(realpath "$0")")"

ln -sf "$dir/configs/$profile/hypridle.conf"     "$dir/hypridle.conf"
ln -sf "$dir/configs/$profile/monitors.lua"     "$dir/configs/monitors.lua"
ln -sf "$dir/configs/$profile/workspaces.lua"   "$dir/configs/workspaces.lua"
ln -sf "$dir/configs/$profile/other.lua"        "$dir/configs/other.lua"
