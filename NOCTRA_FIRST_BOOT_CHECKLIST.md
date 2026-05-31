# Noctra First-Boot Checklist

Use this checklist after a fresh install and reboot to validate that the installation path produces a coherent Noctra first-boot experience.

## Boot sequence expectations

### 1. Firmware / bootloader screen

Expected:

- Limine menu uses Tokyo Night-like dark styling.
- Branding text reads: `Noctra Bootloader`.
- The default target OS name is `Noctra Hyprland Edition` through `/etc/default/limine`.
- Boot entries should be present in `/boot/limine.conf` after `limine-update` or the `limine-mkinitcpio-hook` deploy hook runs.

Validate:

```bash
grep -n 'interface_branding\|Noctra Bootloader' /boot/limine.conf
grep -n 'TARGET_OS_NAME="Noctra Hyprland Edition"' /etc/default/limine
```

### 2. Plymouth appearance

Expected:

- Plymouth uses the installed theme name `omarchy` internally, but the visible logo should be Noctra.
- If present, `assets/noctra/plymouth/plymouth-logo.png` is copied to `/usr/share/plymouth/themes/omarchy/logo.png`.
- The same Plymouth-specific logo is copied to `/usr/share/plymouth/themes/omarchy/logos/oma.png`.
- If the Plymouth-specific logo is missing, `assets/noctra/logos/noctra-logo.png` is used as the fallback.

Validate:

```bash
plymouth-set-default-theme
sudo test -f /usr/share/plymouth/themes/omarchy/logo.png
sudo test -f /usr/share/plymouth/themes/omarchy/logos/oma.png
```

Visual check:

- Dark boot background.
- Centered Noctra logo.
- No Omarchy wordmark visible to the user during the Plymouth prompt/animation.

### 3. SDDM appearance

Expected:

- SDDM runs on Wayland with Hyprland as the greeter compositor.
- Theme path remains `/usr/share/sddm/themes/omarchy`, but visible theme metadata and artwork are Noctra.
- Login theme name is `Noctra Hyprland Edition`.
- Logo is copied from `assets/noctra/logos/noctra-logo.png` into the SDDM theme.
- Background is copied from `assets/noctra/sddm/sddm-background.png` into the SDDM theme.
- Autologin uses `Session=omarchy` to match the installed `omarchy.desktop` session file.

Validate:

```bash
systemctl is-enabled sddm.service
grep -n 'DisplayServer=wayland\|CompositorCommand=start-hyprland' /etc/sddm.conf.d/10-wayland.conf
grep -n 'Session=omarchy\|Current=omarchy' /etc/sddm.conf.d/autologin.conf
grep -n 'Name=Noctra Hyprland Edition' /usr/share/sddm/themes/omarchy/metadata.desktop
sudo test -f /usr/share/sddm/themes/omarchy/logo.png
sudo test -f /usr/share/sddm/themes/omarchy/background.png
```

Visual check:

- Dark SDDM background image.
- Centered Noctra logo.
- Minimal terminal-style password entry.
- No Omarchy wordmark visible in the greeter.

### 4. Session name

Expected:

- Session file path: `/usr/local/share/wayland-sessions/omarchy.desktop`.
- Visible session name: `Noctra Hyprland Edition`.
- Session comment: `Noctra Hyprland session managed by uwsm`.
- Exec line: `uwsm start -g -1 -e -D Hyprland hyprland.desktop`.

Validate:

```bash
grep -n 'Name=Noctra Hyprland Edition\|Comment=Noctra Hyprland session managed by uwsm\|Exec=uwsm start' /usr/local/share/wayland-sessions/omarchy.desktop
```

### 5. First login / desktop startup

Expected:

- SDDM autologs into the `omarchy` session unless the user changed autologin.
- Hyprland starts without the upstream Hyprland splash/logo.
- The following startup services are launched by the default Hypr autostart config:
  - `hypridle`
  - `mako`
  - `waybar` unless disabled by the Waybar toggle
  - `fcitx5 --disable notificationitem`
  - `swaybg -i ~/.config/omarchy/current/background -m fill`
  - polkit GNOME agent
  - `omarchy-first-run`
  - power profiles initialization
  - monitor watch
- `omarchy-first-run` runs only when `~/.local/state/omarchy/first-run.mode` exists, then removes that marker.

Validate:

```bash
test ! -f ~/.local/state/omarchy/first-run.mode
pgrep -x Hyprland
pgrep -x waybar
pgrep -x swaybg
pgrep -x mako
```

### 6. Wallpaper

Expected:

- Current background symlink: `~/.config/omarchy/current/background`.
- Fresh Noctra install should point to `~/.local/share/omarchy/assets/noctra/wallpapers/wallpaper.png` when that file exists.
- `swaybg` should be running with `-i ~/.config/omarchy/current/background -m fill`.

Validate:

```bash
readlink -f ~/.config/omarchy/current/background
pgrep -a swaybg
```

Visual check:

- Desktop wallpaper is the Noctra default wallpaper, not a theme fallback and not upstream Omarchy art.

### 7. Lockscreen

Expected:

- Hyprlock background path is `~/.local/share/omarchy/assets/noctra/wallpapers/lockscreen.png`.
- Prompt text is `Enter Password`.
- Theme colors are sourced from `~/.config/omarchy/current/theme/hyprlock.conf`.

Validate:

```bash
grep -n 'assets/noctra/wallpapers/lockscreen.png\|placeholder_text = Enter Password' ~/.config/hypr/hyprlock.conf
hyprlock --immediate
```

Visual check:

- Lock screen shows the Noctra lockscreen image.
- No Omarchy wordmark is visible.

### 8. Fastfetch output

Expected:

- Fastfetch logo source: `~/.config/omarchy/branding/about.txt`.
- `about.txt` is copied from repository `icon.txt`, which contains a Noctra text logo.
- OS line prints `Noctra Hyprland Edition $version`.

Validate:

```bash
grep -n 'Noctra Hyprland Edition' ~/.config/fastfetch/config.jsonc
grep -n 'NOCTRA' ~/.config/omarchy/branding/about.txt
fastfetch
```

Visual check:

- ASCII/art logo reads `NOCTRA`.
- Software OS line reads `Noctra Hyprland Edition <version>`.

### 9. Expected Noctra branding locations

| Surface | Expected location | Expected visible result |
| --- | --- | --- |
| Installer banner | `boot.sh`, `logo.txt` | Noctra ASCII banner / Noctra Hyprland Edition text. |
| Install progress | `install/helpers/presentation.sh` via `logo.txt` | Noctra install UI. |
| Install completion | `install/post-install/finished.sh` via `logo.txt` | Noctra completion animation. |
| Bootloader | `/boot/limine.conf`, `/etc/default/limine` | `Noctra Bootloader`, `Noctra Hyprland Edition`. |
| Plymouth | `/usr/share/plymouth/themes/omarchy/logo.png` | Noctra logo image. |
| SDDM | `/usr/share/sddm/themes/omarchy/logo.png`, `background.png`, `metadata.desktop` | Noctra login artwork and theme name. |
| Session chooser | `/usr/local/share/wayland-sessions/omarchy.desktop` | `Noctra Hyprland Edition`. |
| Desktop wallpaper | `~/.config/omarchy/current/background` | Noctra wallpaper. |
| Lockscreen | `~/.config/hypr/hyprlock.conf` | Noctra lockscreen wallpaper. |
| Fastfetch | `~/.config/fastfetch/config.jsonc`, `~/.config/omarchy/branding/about.txt` | Noctra ASCII logo and OS name. |
| Screensaver/about branding | `~/.config/omarchy/branding/screensaver.txt`, `about.txt` | Noctra text branding. |
| Waybar menu tooltip | `~/.config/waybar/config.jsonc` | `Noctra Menu`. |

## First-boot pass/fail notes

Pass criteria:

- No visible Omarchy wordmark appears in Limine, Plymouth, SDDM, lockscreen, Fastfetch, or the default desktop wallpaper.
- The session name shown by SDDM is `Noctra Hyprland Edition`.
- `fastfetch` reports `Noctra Hyprland Edition`.
- `~/.local/state/omarchy/first-run.mode` is removed after first login.
- Temporary first-run sudoers files are cleaned up.

Known acceptable inherited internals:

- Paths and service/theme identifiers such as `~/.local/share/omarchy`, `~/.config/omarchy`, `/usr/share/sddm/themes/omarchy`, `/usr/share/plymouth/themes/omarchy`, `omarchy.desktop`, and `Session=omarchy` remain for compatibility.
- Commands continue to use the `omarchy` CLI namespace.
