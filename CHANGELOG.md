# Changelog

All notable changes to **kiro-hlwm** are documented here. Dates are `YYYY.MM.DD`,
newest first.

## 2026.07.18

### What Changed

Initial config package — the herbstluftwm (hlwm) edition of Kiro, minted through
`/kiro-create-x11-twm`. Second X11 tiling-WM edition after kiro-dusk.

### Technical Details

- **Config-file family** (herbstluftwm is a distro package): copy-only, `arch=any`,
  no compile. Relies on the upstream `herbstluftwm.desktop` session file rather
  than shipping its own (avoids a duplicate greeter entry).
- Single `~/.config/herbstluftwm/autostart` fuses the WM config (keybindings,
  rules, tags, theme via `herbstclient`) with the AUTOSTART_TEMPLATE common body
  (tray applets, fastcompmgr, feh wallpaper, numlockx, polkit). "Called-by-WM"
  autostart family — no separate run.sh, no WM loop.
- Keybindings modelled on the ohmychadwm master set, SUPER (Mod4) modifier,
  translated into herbstluftwm vocabulary. QWERTY default with `be`→AZERTY
  number-row auto-detection.
- polybar status bar (self-contained in the config dir) with a clickable
  herbstclient-driven tags module.
- rofi launcher theme, fastcompmgr compositor toggle, Kiro wallpaper default.
- `super+shift+d` opens the same rofi launcher as `super+d` (both bound to rofi).
- Default frame layout is **horizontal** (windows side by side), not the stock
  vertical — set via `default_frame_layout horizontal` before the tags are created
  so every tag's root frame adopts it on first login.

### Files Modified

- Initial commit — full `etc/skel/.config/herbstluftwm/` tree + scaffold.
