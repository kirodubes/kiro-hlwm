# kiro-hlwm

The **herbstluftwm** edition of Kiro — a manual tiling X11 desktop, configured
entirely at runtime through `herbstclient`, wired into the Kiro look and the
ohmychadwm keybinding family.

## What it is

herbstluftwm (hlwm) is a lightweight, manual tiling window manager for X11. It
tiles by splitting each monitor into a **frame tree** and organises work into
**tags** (workspaces). Unlike the compiled suckless window managers, hlwm needs
no compile step: its whole configuration is a shell script (`autostart`) that
fires `herbstclient` commands. `super+shift+r` reloads it live.

This package layers the Kiro identity on top of stock herbstluftwm:

- **SUPER-based keybindings** modelled on the ohmychadwm master set (apps, tags,
  layout, screenshots, session), translated into herbstluftwm's own vocabulary.
- **polybar** status bar with a clickable, herbstclient-driven tags module,
  shipped self-contained inside the config directory.
- **rofi** app launcher, **fastcompmgr** compositor (toggle with `super+g`),
  **feh** wallpaper (Kiro default), tray applets, polkit agent, numlockx.
- QWERTY by default; a Belgian (`be`) layout auto-loads the AZERTY number-row.

## What it ships

```
etc/skel/.config/herbstluftwm/
├── autostart                     # WM config + session autostart (the whole config)
├── keybindings.txt               # human-readable cheatsheet (super+ctrl+s)
├── bg/kiro.jpg                   # default wallpaper
├── rofi/                         # rofi launcher theme
├── scripts/fastcompmgr-toggle.sh # super+g compositor toggle
└── polybar/
    ├── config.ini                # bar definition
    ├── launch.sh                 # (re)starts polybar, one bar per monitor
    └── scripts/herbstclient-tags.sh   # clickable tags module
```

The session itself is provided by the upstream `herbstluftwm` package's
`/usr/share/xsessions/herbstluftwm.desktop` — this package does **not** ship its
own session file (that would create a duplicate greeter entry).

## How to install

```bash
sudo pacman -S kiro-hlwm
```

Then pick the **herbstluftwm** session in your display manager and log in. The
config is seeded from `/etc/skel` on first login. Press **super+ctrl+s** for the
keybinding cheatsheet.

<!-- KIRO-FUNDING-FOOTER:START — managed by Kiro-HQ/cascade-readme-footer.sh -->
## Help fund Kiro

Everything I build here stays free and open — always. If Kiro or any of these
tools have ever saved you time or taught you something, a small monthly
contribution helps keep the work going. Donations target break-even, nothing
more — the core always stays free for everyone.

- GitHub Sponsors: https://github.com/sponsors/erikdubois
- Patreon: https://www.patreon.com/c/kiroproject
- YouTube memberships: https://www.youtube.com/@ErikDubois/join
- Ko-fi: https://ko-fi.com/erikdubois
- PayPal: https://www.paypal.me/erikdubois
<!-- KIRO-FUNDING-FOOTER:END -->
