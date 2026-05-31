# Noctra Asset Application Report

## Summary

This pass keeps the Noctra asset workflow, scripts, and text/config wiring, but deliberately removes all PNG/JPG/WEBP/GIF/ICO additions and modifications from the Codex PR flow. Binary image assets must be uploaded or committed manually outside the Codex PR flow because this PR creation path cannot include binary file changes.

The repository expects user-provided Noctra assets under `assets/noctra/...`. After those binary assets are manually uploaded, run `scripts/apply-noctra-assets.sh` locally or include its generated image changes in a normal GitHub commit workflow that supports binary files.

Command names, service names, state/config paths, Plymouth theme paths, and SDDM theme paths intentionally remain `omarchy` where they are compatibility identifiers.

## Display manager detected

**Detected display manager:** SDDM.

Evidence:

- `install/login/all.sh` runs `install/login/sddm.sh` during the login stage.
- `install/login/sddm.sh` installs the theme with `omarchy-refresh-sddm`, writes `/etc/sddm.conf.d/10-wayland.conf`, writes or updates `/etc/sddm.conf.d/autologin.conf`, and enables `sddm.service`.
- Historical migrations also migrate systems to SDDM and update SDDM autologin/session settings.

No greetd, Ly, LightDM, or GDM install path is active in the current login install sequence. Auto-login is configured through SDDM's `autologin.conf`; SDDM is not bypassed.

## Asset sources discovered

| Area | Current source/path | Integration notes |
| --- | --- | --- |
| Logo assets | `logo.txt`, `icon.txt`, `logo.svg`, `icon.png`, `default/plymouth/logo.png`, `default/sddm/omarchy/logo.png` | Text branding already says Noctra. Raster replacements must be supplied manually in `assets/noctra/logos/` and applied outside the Codex PR flow. |
| Plymouth assets | `default/plymouth/*`, refreshed by `bin/omarchy-refresh-plymouth` and `bin/omarchy-plymouth-reset` into `/usr/share/plymouth/themes/omarchy` | `scripts/apply-noctra-assets.sh` expects `assets/noctra/plymouth/plymouth-logo.png` or fallback logo assets, then copies them to Plymouth targets when run manually. |
| Login/display manager assets | `default/sddm/omarchy/*`, refreshed by `bin/omarchy-refresh-sddm` into `/usr/share/sddm/themes/omarchy` | SDDM remains the display manager. The QML can render a manually applied `background.png`; the binary background itself is not included in this PR. |
| Wallpapers | `themes/*/backgrounds/*`, selected through `omarchy-theme-bg-next` and linked at `~/.config/omarchy/current/background` | `scripts/apply-noctra-assets.sh` expects `assets/noctra/wallpapers/wallpaper.png` and can copy it into wallpaper targets outside the Codex PR flow. |
| Lock screen backgrounds | `config/hypr/hyprlock.conf` | The default lock screen remains on the existing current background path so this PR does not reference a missing binary file. The helper still documents and stages a Noctra lockscreen target when assets are applied manually. |
| Fastfetch/terminal branding | `config/fastfetch/config.jsonc`, `icon.txt`, `logo.txt`, `~/.config/omarchy/branding/about.txt`, `~/.config/omarchy/branding/screensaver.txt` | Existing text branding displays Noctra. Uploaded raster assets are not directly consumed by fastfetch unless users transcode them with branding commands. |
| README screenshots | README currently has no image references. Optional `assets/noctra/screenshots/*.png` files are not present in the Codex PR. | README screenshots should be added manually in a binary-capable workflow. |
| Boot branding | `default/limine/default.conf`, `default/limine/limine.conf`, `default/plymouth/*` | Limine already names Noctra in text branding; Plymouth logo replacement is handled by the helper after manual binary upload. No Limine/GRUB background image assets are included in this PR. |

## Binary assets removed from this PR

The previous Codex commit added or modified binary images. Those binary changes have been reverted from the cumulative PR diff. The cleanup covers these categories:

- Root and source logo aliases such as `logo.png` and `assets/noctra/logos/logo.png`.
- Plymouth binary targets such as `default/plymouth/logo.png` and `default/plymouth/logos/oma.png`.
- SDDM binary targets such as `default/sddm/omarchy/logo.png` and `default/sddm/omarchy/background.png`.
- Theme wallpaper binary targets under `themes/*/backgrounds/*omarchy*.png`.
- New Tokyo Night binary wallpaper/lockscreen targets under `themes/tokyo-night/backgrounds/`.

No PNG/JPG/WEBP/GIF/ICO files are intentionally added or modified by the final cumulative PR diff.

## Manual asset workflow retained

| Expected user-provided asset | Manual target(s) populated by `scripts/apply-noctra-assets.sh` |
| --- | --- |
| `assets/noctra/plymouth/plymouth-logo.png` | `default/plymouth/logo.png`, `default/plymouth/logos/oma.png` |
| `assets/noctra/logos/logo.png` or `assets/noctra/logos/noctra-logo.png` | `default/sddm/omarchy/logo.png`, optional root `logo.png` |
| `assets/noctra/sddm/sddm-background.png` | `default/sddm/omarchy/background.png` |
| `assets/noctra/wallpapers/wallpaper.png` | `themes/tokyo-night/backgrounds/0-noctra.png`, `themes/tokyo-night/backgrounds/omarchy.png`, safe `themes/*/backgrounds/*omarchy*.png` targets |
| `assets/noctra/wallpapers/lockscreen.png` | `themes/tokyo-night/backgrounds/lockscreen.png` |

Run this after manually committing or otherwise making binary assets available:

```bash
scripts/apply-noctra-assets.sh
```

Use this in a normal binary-capable Git workflow if you want to commit generated image replacements:

```bash
scripts/apply-noctra-assets.sh --strict
git status --short
```

## Text/config wiring kept in this PR

- `scripts/apply-noctra-assets.sh` retains the Noctra copy workflow and supports the uploaded asset naming variants.
- `default/sddm/omarchy/Main.qml` includes a documented `background.png` image layer so a manually applied SDDM background is used when present.
- `NOCTRA_ASSET_APPLICATION_REPORT.md` documents where assets should go, which display manager is used, what remains manual, and which binary files are intentionally excluded from the Codex PR.

## Verification mapping

| Requirement | Final PR state |
| --- | --- |
| Plymouth shows Noctra branding | Manual binary step required. The helper maps `assets/noctra/plymouth/plymouth-logo.png` to the Plymouth target paths. |
| Login screen uses Noctra branding if applicable | SDDM is applicable. The QML wiring is present, but the binary logo/background replacement must be committed manually outside Codex. |
| Default wallpaper is Noctra `wallpaper.png` | Manual binary step required. The helper maps `assets/noctra/wallpapers/wallpaper.png` to the default Tokyo Night targets. |
| Lock screen uses `lockscreen.png` | Manual binary step required. The helper maps `assets/noctra/wallpapers/lockscreen.png` to a lockscreen target, while the default config avoids referencing a missing PR-excluded image. |
| Fastfetch/terminal branding uses Noctra | Existing text branding already uses Noctra via `logo.txt`, `icon.txt`, and fastfetch configuration. |
| Boot branding references Noctra assets where supported | Limine text branding remains Noctra. Plymouth raster replacement is available through the manual helper workflow. |

## Assets not currently used automatically

Additional curated wallpapers in `assets/noctra/wallpapers/` should remain source assets and are not automatically selected by the default install path unless a future binary-capable commit wires them into theme rotation.

## Remaining Omarchy-branded image paths

The following image paths retain Omarchy-compatible names because renaming them would affect theme conventions, compatibility paths, or historical references:

- `default/plymouth/logos/oma.png`
- `default/sddm/omarchy/*`
- `themes/*/backgrounds/omarchy.png`
- `themes/flexoki-light/backgrounds/2-omarchy.png`
- `themes/rose-pine/backgrounds/3-omarchy-plants.png`
- `themes/tokyo-night/backgrounds/4-oma-cityscape.jpg`
- `themes/tokyo-night/backgrounds/5-oma.jpg`

These files are not replaced in this PR because binary image modifications are excluded.

## Missing/manual assets

The following optional assets are still manual binary inputs and were not generated or embedded:

- `assets/noctra/screenshots/README.png`
- `assets/noctra/screenshots/README-dark.png`
- `assets/noctra/screenshots/README-terminal.png`
- `assets/noctra/screenshots/README-installer.png`
- `assets/noctra/screenshots/README-lock.png`
- `assets/noctra/boot/grub-background.png`
- `assets/noctra/boot/limine-background.png`
- `assets/noctra/boot/boot-menu-logo.png`
- Exact icon-sized replacements such as `assets/noctra/logos/noctra-icon.png`
- Exact SVG replacement such as `assets/noctra/logos/noctra-logo.svg`
- Plymouth control assets such as `bullet.png`, `entry.png`, `lock.png`, `progress_bar.png`, and `progress_box.png`

## Recommended next visual improvements

1. Upload exact icon assets for `icon.png` and `default/chromium/extensions/copy-url/icon.png` in a binary-capable workflow.
2. Add a Noctra SVG logo so `logo.svg` can be safely replaced.
3. Add Plymouth control assets (`bullet`, `entry`, `lock`, progress images) for a complete boot/unlock visual pass.
4. Add README screenshots after boot, login, desktop, lock, and terminal visuals are final.
5. Consider adding a curated Noctra wallpaper rotation path that includes the additional wallpapers without replacing every theme's distinctive background set.
6. Provide JPEG-formatted replacements or rename-safe migration logic for the remaining Tokyo Night `4-oma-cityscape.jpg` and `5-oma.jpg` files.
