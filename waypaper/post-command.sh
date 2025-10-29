#!/bin/bash

wallust run $1 -s && hyprctl reload && killall -SIGUSR2 waybar && kill -SIGUSR1 $KITTY_PID