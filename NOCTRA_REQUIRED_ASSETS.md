# Noctra Required Assets

This asset-preparation pass is based on `NOCTRA_ASSET_REPLACEMENT_REPORT.md`, `NOCTRA_SAFE_RENAME_REPORT.md`, and `NOCTRA_SAFE_RENAME_PASS_SUMMARY.md`. It prepares final artwork drop-in paths for Noctra Hyprland Edition while intentionally preserving inherited Omarchy command names, install paths, state paths, hooks, theme paths, SDDM/Plymouth directory names, and other high/critical compatibility identifiers.

## Drop-in workflow

1. Export final artwork with the file names listed below.
2. Place each file under the matching `assets/noctra/` subfolder.
3. Preview the planned copy pass without strict enforcement:

   ```bash
   scripts/apply-noctra-assets.sh
   ```

4. When the required core artwork is present, enforce completeness:

   ```bash
   scripts/apply-noctra-assets.sh --strict
   ```

The helper copies only inside the repository, does not require root, is safe to run repeatedly, prints `copied:` or `unchanged:` for destinations it can process, and warns for missing optional files. With `--strict`, missing required assets make the script fail after reporting all missing required files.

## Global style direction

All Noctra artwork should feel dark, black/purple, polished, minimal, Hyprland-focused, and clearly Noctra OS branded. Favor high contrast, clean geometry, restrained glow, and enough empty space for login, lock, terminal, and boot contexts.

## Boot / installer

| Recommended file name | Dimensions | Format | Transparent background? | Current source file it will replace | Referencing config/script files | Replace now or wait? | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `assets/noctra/boot/boot-menu-logo.png` | 800x188 | PNG | Yes | None currently present | No direct current text reference found | Wait for final artwork | Optional future boot-menu brand mark. Keep inherited bootloader config filenames intact. |
| `assets/noctra/boot/limine-background.png` | 3840x2160 | PNG | No | None currently present | `default/limine/default.conf`, `default/limine/limine.conf`, `bin/omarchy-refresh-limine` if a future background reference is added | Wait for final artwork | Optional dark Noctra boot-menu background; current Limine files only need visible labels. |
| `assets/noctra/boot/grub-background.png` | 3840x2160 | PNG | No | None currently present | No GRUB config found in this repository | Wait for final artwork | Placeholder only; use if GRUB support is introduced later. |

## Plymouth

| Recommended file name | Dimensions | Format | Transparent background? | Current source file it will replace | Referencing config/script files | Replace now or wait? | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `assets/noctra/plymouth/logo.png` | 800x188 | PNG | Yes | `default/plymouth/logo.png` | `default/plymouth/omarchy.script`, `bin/omarchy-plymouth-set`, `bin/omarchy-transcode-ascii`, `default/sddm/omarchy/Main.qml` | Must wait for final artwork | Main boot logo; dark/purple Noctra wordmark or lockup. Required by `--strict`. |
| `assets/noctra/plymouth/oma.png` | 800x378 | PNG | Yes | `default/plymouth/logos/oma.png` | No direct current text reference found | Wait for final artwork | Legacy inherited Plymouth logo slot; keep path name for compatibility. |
| `assets/noctra/plymouth/bullet.png` | 14x14 | PNG | Yes | `default/plymouth/bullet.png` | `default/plymouth/omarchy.script`, `bin/omarchy-plymouth-set`, `default/sddm/omarchy/Main.qml` | Must wait for final artwork | Password bullet dot, minimal purple/foreground glyph. Required by `--strict`. |
| `assets/noctra/plymouth/entry.png` | 286x48 | PNG | Yes | `default/plymouth/entry.png` | `default/plymouth/omarchy.script`, `bin/omarchy-plymouth-set`, `default/sddm/omarchy/Main.qml` | Must wait for final artwork | Password entry field frame, dark polished glass/outline. Required by `--strict`. |
| `assets/noctra/plymouth/lock.png` | 84x96 | PNG | Yes | `default/plymouth/lock.png` | `default/plymouth/omarchy.script`, `bin/omarchy-plymouth-set`, `default/elephant/omarchy_unlocks.lua`, `default/sddm/omarchy/Main.qml` | Must wait for final artwork | Unlock/lock glyph in Noctra style. Required by `--strict`. |
| `assets/noctra/plymouth/progress_bar.png` | 300x10 | PNG | Yes | `default/plymouth/progress_bar.png` | `default/plymouth/omarchy.script`, `bin/omarchy-plymouth-set` | Wait for final artwork | Foreground progress fill; should recolor cleanly with theme foreground. |
| `assets/noctra/plymouth/progress_box.png` | 300x10 | PNG | Yes | `default/plymouth/progress_box.png` | `default/plymouth/omarchy.script` | Wait for final artwork | Progress track/background; subtle and minimal. |
| `assets/noctra/plymouth/preview-unlock.png` | 1920x1080 | PNG | No | `default/plymouth/preview-unlock.png` | `default/elephant/omarchy_unlocks.lua` | Regenerate after final artwork | Unlock preview image for the picker; compose from final wallpaper/logo. |

## SDDM login

| Recommended file name | Dimensions | Format | Transparent background? | Current source file it will replace | Referencing config/script files | Replace now or wait? | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `assets/noctra/sddm/logo.png` | 800x188 | PNG | Yes | `default/sddm/omarchy/logo.png` | `default/sddm/omarchy/Main.qml`, `bin/omarchy-plymouth-set` | Must wait for final artwork | Login logo matching Plymouth, with inherited SDDM path preserved. Required by `--strict`. |
| `assets/noctra/sddm/bullet.png` | 14x14 | PNG | Yes | `default/sddm/omarchy/bullet.png` | `default/sddm/omarchy/Main.qml`, `bin/omarchy-plymouth-set` | Must wait for final artwork | Password bullet. Required by `--strict`. |
| `assets/noctra/sddm/entry.png` | 286x48 | PNG | Yes | `default/sddm/omarchy/entry.png` | `default/sddm/omarchy/Main.qml`, `bin/omarchy-plymouth-set` | Must wait for final artwork | Normal password field. Required by `--strict`. |
| `assets/noctra/sddm/entry-failed.png` | 286x48 | PNG | Yes | `default/sddm/omarchy/entry-failed.png` | `default/sddm/omarchy/Main.qml`, `bin/omarchy-plymouth-set` | Wait for final artwork | Error-state password field, using restrained red/pink accent. |
| `assets/noctra/sddm/lock.png` | 84x96 | PNG | Yes | `default/sddm/omarchy/lock.png` | `default/sddm/omarchy/Main.qml`, `bin/omarchy-plymouth-set` | Must wait for final artwork | Normal lock icon. Required by `--strict`. |
| `assets/noctra/sddm/lock-failed.png` | 84x96 | PNG | Yes | `default/sddm/omarchy/lock-failed.png` | `default/sddm/omarchy/Main.qml`, `bin/omarchy-plymouth-set` | Wait for final artwork | Error-state lock icon, matching `entry-failed.png`. |

## Hyprland wallpaper

| Recommended file name | Dimensions | Format | Transparent background? | Current source file it will replace | Referencing config/script files | Replace now or wait? | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `assets/noctra/wallpapers/noctra-4k.png` | 3840x2160 | PNG | No | `themes/*/backgrounds/omarchy.png` and `themes/flexoki-light/backgrounds/2-omarchy.png` | `default/elephant/omarchy_background_selector.lua`, `bin/omarchy-theme-bg-cache`, `bin/omarchy-theme-bg-switcher` through theme background discovery | Must wait for final artwork | Core 4K Noctra Hyprland wallpaper fallback copied to every inherited Omarchy wallpaper slot by the helper. Required by `--strict`. |
| `assets/noctra/wallpapers/<theme>.png` | 3840x2160 | PNG | No | Matching `themes/<theme>/backgrounds/omarchy.png` | Same background selectors/cache helpers as above | Optional now, final later | Optional per-theme overrides. Use exact theme directory names such as `catppuccin.png`, `tokyo-night.png`, or `vantablack.png`. |

## Lock screen

| Recommended file name | Dimensions | Format | Transparent background? | Current source file it will replace | Referencing config/script files | Replace now or wait? | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `assets/noctra/plymouth/preview-unlock.png` | 1920x1080 | PNG | No | `default/plymouth/preview-unlock.png` | `default/elephant/omarchy_unlocks.lua` | Regenerate after final artwork | Default unlock preview shown by the Elephant unlock picker. |
| `assets/noctra/screenshots/<theme>-preview-unlock.png` | 1920x1080 | PNG | No | `themes/*/preview-unlock.png` | `default/elephant/omarchy_unlocks.lua` | Wait; not copied by helper yet | Theme lock previews should be regenerated after the final wallpaper/logo pass rather than hand-authored first. |
| `assets/noctra/screenshots/<theme>-unlock.png` | 800x188 unless theme-specific source requires 800x378/1108x523/541x278 | PNG | Yes | `themes/*/unlock.png` | `bin/omarchy-plymouth-set-by-theme`, `default/elephant/omarchy_unlocks.lua` | Wait; not copied by helper yet | Theme unlock logos feed Plymouth theme selection. Keep transparent where the existing unlock asset is a logo. |

## Fastfetch / terminal logo

| Recommended file name | Dimensions | Format | Transparent background? | Current source file it will replace | Referencing config/script files | Replace now or wait? | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `assets/noctra/logos/noctra-terminal-logo.txt` | Text sized for terminal splash | Plain text | N/A | `logo.txt` | `bin/omarchy-branding-screensaver`, `bin/omarchy-show-logo`, `bin/omarchy-transcode-ascii`, `install/config/branding.sh`, `install/helpers/presentation.sh`, `install/post-install/finished.sh` | Optional now; final later | ASCII/ANSI Noctra terminal mark. Existing text is already Noctra-branded but can be refined. |
| `assets/noctra/logos/noctra-fastfetch-about.txt` | Text sized for fastfetch side logo | Plain text | N/A | `icon.txt` | `config/fastfetch/config.jsonc`, `bin/omarchy-branding-about`, `install/config/branding.sh` | Optional now; final later | Fastfetch/about-panel ASCII mark. Existing text is already Noctra-branded but can be refined. |

## README screenshots

| Recommended file name | Dimensions | Format | Transparent background? | Current source file it will replace | Referencing config/script files | Replace now or wait? | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `assets/noctra/screenshots/README.png` | 2880x1800 or 1920x1080 | PNG | No | None currently present | `README.md` if screenshots are added later | Wait for final artwork | Hero desktop screenshot after final wallpaper/login/theme polish. |
| `assets/noctra/screenshots/README-terminal.png` | 2880x1800 or 1920x1080 | PNG | No | None currently present | `README.md` if screenshots are added later | Wait for final artwork | Terminal/fastfetch screenshot demonstrating Noctra branding. |
| `assets/noctra/screenshots/README-installer.png` | 2880x1800 or 1920x1080 | PNG | No | None currently present | `README.md` if screenshots are added later | Wait for final artwork | Optional installer/setup screenshot. |
| `assets/noctra/screenshots/README-lock.png` | 1920x1080 | PNG | No | None currently present | `README.md` if screenshots are added later | Wait for final artwork | Optional lock/login presentation screenshot. |

## Icons / SVGs

| Recommended file name | Dimensions | Format | Transparent background? | Current source file it will replace | Referencing config/script files | Replace now or wait? | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `assets/noctra/logos/noctra-logo.svg` | Scalable, optimized for 800x188 lockup use | SVG | Yes | `logo.svg` | `bin/omarchy-plymouth-set`, `bin/omarchy-transcode-ascii` | Must wait for final artwork | Primary Noctra vector logo/wordmark. Required by `--strict`. |
| `assets/noctra/logos/noctra-icon.png` | 300x300 | PNG | Yes | `icon.png`, `default/chromium/extensions/copy-url/icon.png` | `default/chromium/extensions/copy-url/manifest.json` | Must wait for final artwork | Square app/repo/extension icon. Required by `--strict`. |
| `assets/noctra/icons/<app-name>.png` | 48x48 minimum, 256x256 preferred | PNG | Yes | `applications/icons/*.png` if Noctra chooses app-icon replacements | `install/packaging/icons.sh`, `install/packaging/webapps.sh`, `install/packaging/tuis.sh`, selected migrations | Wait; optional and not copied by helper | Preserve third-party app identities unless final Noctra icon guidelines explicitly replace them. |

## Web/social preview images if present

No web/social preview images are currently referenced in the repository. If Noctra adds website or repository preview metadata later, use:

| Recommended file name | Dimensions | Format | Transparent background? | Current source file it will replace | Referencing config/script files | Replace now or wait? | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `assets/noctra/screenshots/social-preview.png` | 1200x630 | PNG | No | None currently present | Future README/site/Open Graph metadata | Wait for final artwork | Dark black/purple Noctra OS social card. |

## GRUB/Limine boot menu if present

Limine config is present and already has Noctra text labels. No image background is currently wired in. GRUB config was not found.

| Recommended file name | Dimensions | Format | Transparent background? | Current source file it will replace | Referencing config/script files | Replace now or wait? | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `assets/noctra/boot/limine-background.png` | 3840x2160 | PNG | No | None currently present | `default/limine/default.conf`, `default/limine/limine.conf`, `bin/omarchy-refresh-limine` if a future background reference is added | Wait for final artwork | Optional future boot-menu background. |
| `assets/noctra/boot/grub-background.png` | 3840x2160 | PNG | No | None currently present | No GRUB config found | Wait for final artwork | Placeholder only. |

## Other themed UI assets

| Recommended file name | Dimensions | Format | Transparent background? | Current source file it will replace | Referencing config/script files | Replace now or wait? | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `assets/noctra/screenshots/<theme>-preview.png` | 1800x1012 for most themes; 2880x1800 for `last-horizon` and `solitude` | PNG | No | `themes/*/preview.png` | `bin/omarchy-theme-switcher`, `default/elephant/omarchy_themes.lua`, `bin/omarchy-capture-screenrecording`, `bin/omarchy-plymouth-preview` | Regenerate after final artwork | Theme switcher previews should be captured after wallpapers, lockups, and colors are final. |
| `assets/noctra/screenshots/<theme>-preview-unlock.png` | 1920x1080 | PNG | No | `themes/*/preview-unlock.png` | `default/elephant/omarchy_unlocks.lua` | Regenerate after final artwork | Lock preview screenshots. |
| `assets/noctra/screenshots/<theme>-unlock.png` | Match existing `themes/<theme>/unlock.png` dimensions | PNG | Yes | `themes/*/unlock.png` | `bin/omarchy-plymouth-set-by-theme`, `default/elephant/omarchy_unlocks.lua` | Regenerate after final artwork | Unlock logo/preview source for per-theme Plymouth. |

## Current required assets missing until final artwork is supplied

- `assets/noctra/logos/noctra-logo.svg`
- `assets/noctra/logos/noctra-icon.png`
- `assets/noctra/plymouth/logo.png`
- `assets/noctra/plymouth/bullet.png`
- `assets/noctra/plymouth/entry.png`
- `assets/noctra/plymouth/lock.png`
- `assets/noctra/sddm/logo.png`
- `assets/noctra/sddm/bullet.png`
- `assets/noctra/sddm/entry.png`
- `assets/noctra/sddm/lock.png`
- `assets/noctra/wallpapers/noctra-4k.png`

## Intentionally preserved compatibility identifiers

The asset workflow does not rename `bin/omarchy`, `bin/omarchy-*`, `$OMARCHY_PATH`, `$OMARCHY_INSTALL`, `~/.local/share/omarchy`, `~/.config/omarchy`, migration state paths, hooks, systemd units, `default/sddm/omarchy`, `default/plymouth/omarchy.*`, or inherited theme wallpaper filenames such as `omarchy.png`.
