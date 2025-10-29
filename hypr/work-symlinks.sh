dir=$(temp=$( realpath "$0"  ) && dirname "$temp")

ln -s "$dir/configs/work/hypridle.conf" "$HOME/.config/hypr/hypridle.conf"
ln -s "$dir/configs/work/monitors.conf" "$HOME/.config/hypr/monitors.conf"
ln -s "$dir/configs/work/workspaces.conf" "$HOME/.config/hypr/workspaces.conf"