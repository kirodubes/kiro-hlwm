#!/usr/bin/env bash
# herbstclient-tags.sh — feed a clickable herbstluftwm tag list to polybar.
# polybar runs this as a `tail = true` custom/script module: it prints the tag
# line once, then re-prints it on every herbstluftwm tag event (--idle stream).
# Click a tag to switch to it.
#
# Usage: herbstclient-tags.sh [monitor-index]   (default 0)

mon=${1:-0}

# Nord-ish palette (matches the frame theme in ../autostart).
c_focus="#88c0d0"   # focused tag on this monitor
c_other="#81a1c1"   # focused on another monitor
c_used="#e5e9f0"    # has windows, not viewed
c_urgent="#bf616a"  # urgent
c_empty="#4c566a"   # empty / not viewed

render() {
  local line="" idx=0 tag sym name
  # tag_status is TAB-separated; each tag carries a one-char state prefix.
  while IFS= read -r -d $'\t' tag; do
    [ -z "$tag" ] && continue
    sym=${tag:0:1}
    name=${tag:1}
    case $sym in
      '#') col=$c_focus ;;
      '+'|'%') col=$c_other ;;
      ':') col=$c_used ;;
      '!') col=$c_urgent ;;
      *)   col=$c_empty ;;
    esac
    # %{A1:…:} makes the label left-clickable → switch to that tag.
    line+="%{A1:herbstclient chain , focus_monitor $mon , use_index $idx:}%{F$col} $name %{F-}%{A}"
    idx=$((idx + 1))
  done < <(printf '%s\t' "$(herbstclient tag_status "$mon")")
  printf '%s\n' "$line"
}

render
herbstclient --idle "tag_*" 2>/dev/null | while read -r _ ; do
  render
done
