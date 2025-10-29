#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Screenshots scripts

# variables
sDIR="$HOME/.config/hypr/scripts"

notify_cmd_base="notify-send -t 10000 -A action1=Open -A action2=Delete -h string:x-canonical-private-synchronous:shot-notify"
notify_cmd_shot="${notify_cmd_base}"

# notify and view screenshot
notify_view() {
		"${sDIR}/Sounds.sh" --screenshot
		resp=$(${notify_cmd_shot} " Screenshot:" " Captured by Swappy")
		case "$resp" in
			action1)
				swappy -f - <"$tmpfile"
				;;
			action2)
				rm "$tmpfile"
				;;
		esac
}

shotswappy() {
	tmpfile=$(mktemp)
	grim -g "$(slurp)" - >"$tmpfile" 

  # Copy without saving
  if [[ -s "$tmpfile" ]]; then
		wl-copy <"$tmpfile"
    notify_view "swappy"
  fi
}

shotswappy
exit 0
