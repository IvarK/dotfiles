#!/usr/bin/env bash

# Games default to workspace 5 via windowrules.lua. Move them to workspace 7
# when Steam's Big Picture window is present.

socket_dir="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/hypr/${HYPRLAND_INSTANCE_SIGNATURE}"
socket="${socket_dir}/.socket2.sock"

# Older Hyprland versions kept their IPC sockets under /tmp.
if [[ ! -S "$socket" ]]; then
  socket="/tmp/hypr/${HYPRLAND_INSTANCE_SIGNATURE}/.socket2.sock"
fi

is_big_picture_open() {
  hyprctl clients -j 2>/dev/null | jq -e '
    any(.[];
      ((.class // "") | test("^steam$"; "i")) and
      (((.title // "") + " " + (.initialTitle // "")) |
        test("big picture"; "i"))
    )
  ' >/dev/null
}

move_game_if_needed() {
  local address="$1"
  local class="$2"

  if [[ ! "$class" =~ ^(gamescope|steam_app_[0-9]+)$ ]]; then
    return
  fi

  if is_big_picture_open; then
    [[ "$address" == 0x* ]] || address="0x${address}"
    hyprctl dispatch movetoworkspace "7,address:${address}" >/dev/null
    hyprctl dispatch focuswindow "address:${address}" >/dev/null
  fi
}

while IFS= read -r event; do
  case "$event" in
    openwindow\>\>*)
      payload="${event#openwindow>>}"
      IFS=, read -r address _workspace class _title <<< "$payload"
      move_game_if_needed "$address" "$class"
      ;;
  esac
done < <(socat -U - "UNIX-CONNECT:${socket}")
