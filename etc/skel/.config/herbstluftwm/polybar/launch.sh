#!/usr/bin/env bash
# launch.sh — (re)start polybar for the herbstluftwm session, one bar per monitor.
# Called from ../autostart on login and on every `herbstclient reload`.

CONFIG=~/.config/herbstluftwm/polybar/config.ini

# Kill any running instance and wait for it to fully exit.
polybar-msg cmd quit >/dev/null 2>&1
killall -q polybar
while pgrep -x polybar >/dev/null; do sleep 0.2; done

# Launch one bar per connected monitor (herbstluftwm reports them by index).
if type herbstclient >/dev/null 2>&1; then
    for m in $(herbstclient list_monitors | cut -d: -f1); do
        MONITOR=$m polybar --reload -c "$CONFIG" main >>/tmp/polybar-hlwm.log 2>&1 &
    done
else
    polybar --reload -c "$CONFIG" main >>/tmp/polybar-hlwm.log 2>&1 &
fi
