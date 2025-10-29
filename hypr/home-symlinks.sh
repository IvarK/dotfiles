dir=$(temp=$( realpath "$0"  ) && dirname "$temp")

ln -sf "$dir/configs/home/hypridle.conf" "$dir/hypridle.conf"
ln -sf "$dir/configs/home/monitors.conf" "$dir/configs/monitors.conf"
ln -sf "$dir/configs/home/workspaces.conf" "$dir/configs/workspaces.conf"