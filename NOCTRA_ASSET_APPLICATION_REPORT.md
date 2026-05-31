# Noctra Asset Application Report

## Summary

The uploaded Noctra PNG assets are present in `assets/noctra/` and are now wired through text/config/script paths without adding, replacing, or modifying any binary image files in this change. Compatibility names and runtime paths that Omarchy expects remain intact, including `omarchy-*` commands, `$OMARCHY_PATH`, `~/.local/share/omarchy`, `/usr/share/plymouth/themes/omarchy`, and `/usr/share/sddm/themes/omarchy`.

## Uploaded Assets Verified

| Asset | Status |
| --- | --- |
| `assets/noctra/logos/noctra-logo.png` | Present |
| `assets/noctra/wallpapers/wallpaper.png` | Present |
| `assets/noctra/wallpapers/lockscreen.png` | Present |
| `assets/noctra/plymouth/plymouth-logo.png` | Present |
| `assets/noctra/sddm/sddm-background.png` | Present |

The user-provided prompt also referenced `assets/noctra/logos/logo.png`; this exact legacy alias is not present. The repository currently contains `assets/noctra/logos/noctra-logo.png`, and the SDDM/Plymouth refresh scripts use that canonical uploaded logo path with `assets/noctra/logos/logo.png` only as an optional compatibility fallback.

## Assets Successfully Integrated

| Area | Uploaded asset | Integration path |
| --- | --- | --- |
| Plymouth | `assets/noctra/plymouth/plymouth-logo.png` | `bin/omarchy-refresh-plymouth` copies it into the installed Plymouth theme as `/usr/share/plymouth/themes/omarchy/logo.png` and `/usr/share/plymouth/themes/omarchy/logos/oma.png` when refreshing Plymouth. |
| SDDM logo | `assets/noctra/logos/noctra-logo.png` | `bin/omarchy-refresh-sddm` copies it into the installed SDDM theme as `/usr/share/sddm/themes/omarchy/logo.png` when refreshing SDDM. |
| SDDM background | `assets/noctra/sddm/sddm-background.png` | `bin/omarchy-refresh-sddm` copies it into the installed SDDM theme as `/usr/share/sddm/themes/omarchy/background.png`; `default/sddm/omarchy/Main.qml` already references `background.png`. |
| Hyprlock | `assets/noctra/wallpapers/lockscreen.png` | `config/hypr/hyprlock.conf` points the default lock background at `~/.local/share/omarchy/assets/noctra/wallpapers/lockscreen.png`. |
| Default wallpaper | `assets/noctra/wallpapers/wallpaper.png` | `install/config/theme.sh` keeps the Tokyo Night initial theme and then sets the startup wallpaper to `$OMARCHY_PATH/assets/noctra/wallpapers/wallpaper.png` when that file exists. |
| Fastfetch branding | Existing `icon.txt`/`logo.txt` text assets | `config/fastfetch/config.jsonc` already uses `~/.config/omarchy/branding/about.txt`, populated from `icon.txt`, so Fastfetch remains Noctra-branded without requiring a PNG. |
| Boot branding | Existing Limine text config | `default/limine/limine.conf` already sets `interface_branding: Noctra Bootloader`; optional boot PNG assets are not referenced because they are not uploaded. |

## Config Files Modified

- `scripts/apply-noctra-assets.sh` now verifies uploaded Noctra assets, reports the active wiring, and checks that the Plymouth, SDDM, Hyprlock, and wallpaper source references resolve without copying or creating image files.
- `bin/omarchy-refresh-plymouth` now overlays uploaded Noctra Plymouth logo assets into the installed Plymouth theme at refresh time, preserving the `omarchy` theme name and internal paths.
- `install/login/plymouth.sh` now delegates initial Plymouth setup to `omarchy-refresh-plymouth` so fresh installs receive the uploaded Noctra Plymouth logo overlay through the same compatibility-preserving refresh path.
- `bin/omarchy-refresh-sddm` now overlays uploaded Noctra SDDM logo/background assets into the installed SDDM theme at refresh time, preserving the inherited `omarchy` SDDM theme path.
- `config/hypr/hyprlock.conf` now references the uploaded Noctra lockscreen asset directly through the installed repository path.
- `install/config/theme.sh` now sets the uploaded Noctra wallpaper as the initial default wallpaper when present.
- `NOCTRA_ASSET_APPLICATION_REPORT.md` was updated with current integration status, unused assets, missing references, and recommendations.

## Current Reference Resolution

| Requirement | Reference | Resolution |
| --- | --- | --- |
| Plymouth references resolve | `default/plymouth/omarchy.script` loads `logo.png`; `bin/omarchy-refresh-plymouth` installs the uploaded Noctra logo to that filename. | Resolves after `omarchy-refresh-plymouth`; source asset exists. |
| SDDM references resolve | `default/sddm/omarchy/Main.qml` loads `background.png` and `logo.png`; `bin/omarchy-refresh-sddm` installs uploaded Noctra assets to those filenames. | Resolves after `omarchy-refresh-sddm`; source assets exist. |
| Hyprlock references resolve | `config/hypr/hyprlock.conf` references `~/.local/share/omarchy/assets/noctra/wallpapers/lockscreen.png`. | Resolves because the tracked source asset exists at `assets/noctra/wallpapers/lockscreen.png` and the installed repo lives at `~/.local/share/omarchy`. |
| Wallpaper references resolve | `install/config/theme.sh` references `$OMARCHY_PATH/assets/noctra/wallpapers/wallpaper.png`. | Resolves because the tracked source asset exists. |

## Assets Currently Used

- `assets/noctra/plymouth/plymouth-logo.png`
- `assets/noctra/logos/noctra-logo.png`
- `assets/noctra/sddm/sddm-background.png`
- `assets/noctra/wallpapers/lockscreen.png`
- `assets/noctra/wallpapers/wallpaper.png`

## Assets Currently Unused

The following uploaded source assets exist but are not referenced by current default runtime configuration or refresh scripts:

- `assets/noctra/wallpapers/neon-forest-night.png`
- `assets/noctra/wallpapers/neon-lake-night.png`
- `assets/noctra/wallpapers/noctra-aurora-horizon.png`
- `assets/noctra/wallpapers/noctra-celestial-dunes.png`
- `assets/noctra/wallpapers/noctra-cosmic-lotus.png`
- `assets/noctra/wallpapers/noctra-emerald-monolith.png`
- `assets/noctra/wallpapers/noctra-fog-monolith.png`
- `assets/noctra/wallpapers/noctra-golden-portal.png`
- `assets/noctra/wallpapers/noctra-lockscreen2.png`
- `assets/noctra/wallpapers/noctra-lunar-eclipse.png`
- `assets/noctra/wallpapers/noctra-matrix-eclipse.png`
- `assets/noctra/wallpapers/noctra-neon-diamond.png`
- `assets/noctra/wallpapers/noctra-orbital-gateway.png`
- `assets/noctra/wallpapers/noctra-sakura-eclipse.png`
- `assets/noctra/wallpapers/noctra-solar-ring.png`
- `assets/noctra/wallpapers/noctra-sunset-eclipse.png`
- `assets/noctra/wallpapers/noctra-violet-gate.png`
- `assets/noctra/wallpapers/noctra-wallpaper2.png`

These can remain as curated source wallpapers for future theme rotation work. They are intentionally not copied over existing theme backgrounds in this text-only commit.

## Remaining Omarchy-Branded Images

These image paths keep inherited Omarchy-compatible names or are still existing upstream visual assets. They were not modified because this change must not alter binary image files:

- `default/plymouth/logos/oma.png`
- `default/sddm/omarchy/logo.png`
- `default/sddm/omarchy/background.png` is intentionally not tracked; it is created only in the installed SDDM theme by `bin/omarchy-refresh-sddm` when the uploaded source exists.
- `themes/*/backgrounds/omarchy.png`
- `themes/flexoki-light/backgrounds/2-omarchy.png`
- `themes/rose-pine/backgrounds/3-omarchy-plants.png`
- `themes/tokyo-night/backgrounds/4-oma-cityscape.jpg`
- `themes/tokyo-night/backgrounds/5-oma.jpg`
- Existing Plymouth/SDDM control images such as `bullet.png`, `entry.png`, `lock.png`, `entry-failed.png`, `lock-failed.png`, `progress_bar.png`, and `progress_box.png`.

## Missing References and Broken References Found

- `assets/noctra/logos/logo.png` was mentioned as an existing asset in the request but is not present in the repository. This is not a broken runtime reference because current scripts use `assets/noctra/logos/noctra-logo.png` first and treat `assets/noctra/logos/logo.png` only as an optional legacy alias.
- `default/sddm/omarchy/Main.qml` references `background.png`, but `default/sddm/omarchy/background.png` is not tracked. This is resolved at install/refresh time by `bin/omarchy-refresh-sddm`, which copies `assets/noctra/sddm/sddm-background.png` to `/usr/share/sddm/themes/omarchy/background.png`.
- No broken Plymouth source reference was found for the installed theme path: `omarchy.script` references `logo.png`, `install/login/plymouth.sh` invokes `omarchy-refresh-plymouth`, and `bin/omarchy-refresh-plymouth` ensures that filename is present in the installed theme from uploaded Noctra assets.
- No broken Hyprlock source reference was found: the configured lockscreen path maps to the tracked uploaded asset after normal Omarchy installation.
- No broken default wallpaper source reference was found: the configured wallpaper path maps to the tracked uploaded asset after normal Omarchy installation.

## Additional Recommended Assets

### Noctra Fastfetch Logo

Recommended filename:
`assets/noctra/logos/fastfetch-logo.png`

Recommended size:
512x512

Format:
PNG

Exact repository location:
`assets/noctra/logos/fastfetch-logo.png`

Purpose:
Optional terminal/Fastfetch image branding if the project later switches from ASCII branding to a raster logo.

### Noctra Legacy Logo Alias

Recommended filename:
`assets/noctra/logos/logo.png`

Recommended size:
512x512

Format:
PNG

Exact repository location:
`assets/noctra/logos/logo.png`

Purpose:
Compatibility alias for older scripts or docs that still refer to `logos/logo.png`.

### Noctra Icon

Recommended filename:
`assets/noctra/logos/noctra-icon.png`

Recommended size:
512x512

Format:
PNG

Exact repository location:
`assets/noctra/logos/noctra-icon.png`

Purpose:
Application icon and compact brand mark source for future binary-capable replacement work.

### Noctra Plymouth Bullet

Recommended filename:
`assets/noctra/plymouth/bullet.png`

Recommended size:
7x7

Format:
PNG

Exact repository location:
`assets/noctra/plymouth/bullet.png`

Purpose:
Password bullet styling for Plymouth disk unlock.

### Noctra Plymouth Entry

Recommended filename:
`assets/noctra/plymouth/entry.png`

Recommended size:
650x100

Format:
PNG

Exact repository location:
`assets/noctra/plymouth/entry.png`

Purpose:
Password entry field styling for Plymouth disk unlock.

### Noctra Plymouth Lock

Recommended filename:
`assets/noctra/plymouth/lock.png`

Recommended size:
84x96

Format:
PNG

Exact repository location:
`assets/noctra/plymouth/lock.png`

Purpose:
Lock icon styling for Plymouth disk unlock.

### Noctra Plymouth Progress Bar

Recommended filename:
`assets/noctra/plymouth/progress_bar.png`

Recommended size:
600x8

Format:
PNG

Exact repository location:
`assets/noctra/plymouth/progress_bar.png`

Purpose:
Filled progress indicator for Plymouth boot progress.

### Noctra Plymouth Progress Box

Recommended filename:
`assets/noctra/plymouth/progress_box.png`

Recommended size:
620x24

Format:
PNG

Exact repository location:
`assets/noctra/plymouth/progress_box.png`

Purpose:
Progress track/backplate for Plymouth boot progress.

### Noctra SDDM Bullet

Recommended filename:
`assets/noctra/sddm/bullet.png`

Recommended size:
7x7

Format:
PNG

Exact repository location:
`assets/noctra/sddm/bullet.png`

Purpose:
Password bullet styling for SDDM login.

### Noctra SDDM Entry

Recommended filename:
`assets/noctra/sddm/entry.png`

Recommended size:
650x100

Format:
PNG

Exact repository location:
`assets/noctra/sddm/entry.png`

Purpose:
Password entry field styling for SDDM login.

### Noctra SDDM Entry Failed

Recommended filename:
`assets/noctra/sddm/entry-failed.png`

Recommended size:
650x100

Format:
PNG

Exact repository location:
`assets/noctra/sddm/entry-failed.png`

Purpose:
Failed-login password entry field styling for SDDM.

### Noctra SDDM Lock

Recommended filename:
`assets/noctra/sddm/lock.png`

Recommended size:
84x96

Format:
PNG

Exact repository location:
`assets/noctra/sddm/lock.png`

Purpose:
Lock icon styling for SDDM login.

### Noctra SDDM Lock Failed

Recommended filename:
`assets/noctra/sddm/lock-failed.png`

Recommended size:
84x96

Format:
PNG

Exact repository location:
`assets/noctra/sddm/lock-failed.png`

Purpose:
Failed-login lock icon styling for SDDM.

### Noctra Limine Background

Recommended filename:
`assets/noctra/boot/limine-background.png`

Recommended size:
3840x2160

Format:
PNG

Exact repository location:
`assets/noctra/boot/limine-background.png`

Purpose:
Optional graphical boot menu background if future Limine configuration supports a repository-supplied raster backdrop.

### Noctra Boot Menu Logo

Recommended filename:
`assets/noctra/boot/boot-menu-logo.png`

Recommended size:
512x512

Format:
PNG

Exact repository location:
`assets/noctra/boot/boot-menu-logo.png`

Purpose:
Optional graphical boot menu logo if future boot branding supports a raster logo.

### Noctra README Screenshot

Recommended filename:
`assets/noctra/screenshots/README.png`

Recommended size:
1920x1080

Format:
PNG

Exact repository location:
`assets/noctra/screenshots/README.png`

Purpose:
Primary README visual after Noctra boot, login, desktop, lock, and terminal visuals are finalized.
