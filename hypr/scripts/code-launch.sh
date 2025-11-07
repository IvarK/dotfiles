#!/usr/bin/env bash

# Preset folders
preset=(
  "$HOME/ivarch"
  "$HOME/dotfiles"
  "$HOME/.config"
)

# Dynamic parent folders
parents=(
  "$HOME/work"
  "$HOME/projects"
)

# Gather all dynamic folders
dynamic=()
for parent in "${parents[@]}"; do
    dynamic+=($(find "$parent" -maxdepth 1 -mindepth 1 -type d))
done

# Combine preset and dynamic, remove duplicates
choices=($(printf "%s\n" "${dynamic[@]}" "${preset[@]}" | sort -u))

# Show rofi menu
selection=$(printf "%s\n" "${choices[@]}" | rofi -dmenu -p "Open in VS Code")

# Open selection
[ -n "$selection" ] && code "$selection"