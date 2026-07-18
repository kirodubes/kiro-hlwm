# CLAUDE.md

This file provides guidance to Claude Code when working with **kiro-hlwm**.

## What this project is

The **herbstluftwm (hlwm)** edition of Kiro — a manual tiling X11 desktop. It
ships as the `kiro-hlwm` package from the Nemesis repo and is deployed by copying
`/etc/skel/.config/herbstluftwm/` to `~/.config/herbstluftwm/` on first login.

Research and decisions: `Kiro-HQ/Docs/study-of-hlwm.md`.

## The Step 2 matrix (design decisions)

| Dimension | Decision |
|---|---|
| **Family / config model** | **Config-file** (herbstluftwm is in Arch `extra`). Configured at **runtime** by a shell script (`autostart`) firing `herbstclient` commands. No compile, no `config.h`, `arch=any`, copy-only `package()`. |
| **Config surface** | Single `~/.config/herbstluftwm/autostart` — WM config (keybinds/rules/tags/theme) fused with the session autostart body. `herbstclient reload` (super+shift+r) re-runs it live. |
| **Session** | Upstream `herbstluftwm.desktop` (`Exec=herbstluftwm`). **We do NOT ship our own `exec-hlwm` / `hlwm.desktop` / `run.sh`** — herbstluftwm already ships an xsession, and a second one would create a duplicate greeter entry. `DESKTOP_SESSION=herbstluftwm`. |
| **Autostart family** | **Called-by-WM** (herbstluftwm runs `autostart`). No separate run.sh, no WM-loop tail. run()-guarded applets survive reloads. |
| **Bar/status** | **polybar**, self-contained in `polybar/` (NOT the bspwm-shaped kiro-polybar package). Clickable tags via `polybar/scripts/herbstclient-tags.sh` (`herbstclient --idle` stream). |
| **Launcher / notify / compositor / lock** | rofi · xfce4-notifyd · fastcompmgr (super+g toggle) / picom · betterlockscreen / slock |
| **Keybindings** | ohmychadwm master set, **SUPER (Mod4)**, herbstluftwm vocabulary. QWERTY default; `be`→AZERTY number-row auto-detect in the Tags section. No sxhkd (hlwm binds its own keys). |
| **Wallpaper** | feh, default = `bg/kiro.jpg` (Kiro), `.fehbg` restore. |

## Gotchas

- **Never ship a `.desktop` / `exec-hlwm`** — upstream owns the session. A second
  entry = duplicate greeter listing, one unconfigured.
- **`herbstclient reload`** re-runs `autostart` on every super+shift+r — tray
  applets MUST stay behind the `run()` `pgrep -x` guard or they stack.
- **Session exit** (archlinux-logout) = `herbstclient quit`. `_detect_desktop()`
  sees `DESKTOP_SESSION=herbstluftwm`; the logout branch keys on that.
- **AZERTY tag keys** — the number-row keysyms differ; the `be`-detect block binds
  the AZERTY set. QWERTY digits are the shipped default.
- **polybar tags** default to monitor 0 (single-bar). Per-monitor tags would need
  one module per monitor index.
- Autostart is exempt from the bash template (`set -euo pipefail`) — it runs under
  the WM with no terminal and must fail tolerantly (per TEMPLATE_EXCLUSIONS.md).

## Key files

| Task | File |
|---|---|
| Change a keybinding / rule / theme | `etc/skel/.config/herbstluftwm/autostart` (then super+shift+r) |
| Change autostart apps | same `autostart`, "Session autostart" section |
| Change the status bar | `etc/skel/.config/herbstluftwm/polybar/config.ini` |
| Change the tags module | `etc/skel/.config/herbstluftwm/polybar/scripts/herbstclient-tags.sh` |
| Update the cheatsheet | `etc/skel/.config/herbstluftwm/keybindings.txt` (keep in lockstep with autostart) |

## Packaging note

`etc/skel/` maps to `/etc/skel/` on the target. Recipe:
`~/KIRO-PKG-BUILD-APPS/kiro-hlwm/`. Rebuild via `flow-kiro-hlwm`.
