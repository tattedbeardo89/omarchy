# Noctra Rebrand Summary

## What changed

- Rebranded the top-level README from Omarchy to **Noctra Hyprland Edition**, positioning it as a dark, polished, Arch-based Hyprland power-user edition of **Noctra OS**.
- Added `NOTICE` to preserve upstream Omarchy attribution and explicitly state that Noctra Hyprland Edition is derived from Omarchy under the MIT License.
- Updated terminal/fastfetch branding text and ASCII art in `logo.txt`, `icon.txt`, `boot.sh`, and `config/fastfetch/config.jsonc`.
- Updated visible installer, update, reinstall, refresh, command-center, menu, first-run, session, SDDM, Plymouth, Limine, Waybar, Hyprland, and helper text to use Noctra/Noctra Hyprland Edition language where it was safe to do so.
- Updated Noctra-facing command metadata summaries while keeping the inherited `omarchy` command names and binary names for compatibility.
- Updated documentation comments and sample config comments that described the visible project identity.
- Generated `NOCTRA_ASSET_REPLACEMENT_REPORT.md` with an audit of image, logo, icon, wallpaper, splash, lockscreen, SVG, PNG, JPG, WEBP, GIF, text-logo, and theme asset files.

## What was intentionally preserved

- The upstream MIT `LICENSE` file and original copyright notice were left intact.
- The inherited `omarchy` CLI command, `omarchy-*` helper binary names, `$OMARCHY_*` environment variables, `~/.local/share/omarchy`, `~/.config/omarchy`, and `~/.local/state/omarchy` paths were preserved to avoid breaking installer, updater, migration, theme, and user-config logic.
- Historical migrations were not rewritten. They are intentionally left as upstream compatibility/history scripts unless a future migration plan explicitly changes state directories and command names.
- Omarchy package repositories, mirrors, and default upstream clone settings were preserved because dedicated Noctra infrastructure was not provided in this pass.
- App/service IDs containing `org.omarchy` or `com.omarchy` were mostly preserved where changing them could break window rules, launch/focus behavior, or installed desktop integration.
- Third-party theme/plugin references such as `omacom-io/lumon.nvim` were preserved because they refer to external upstream package sources rather than Noctra-owned branding.

## What still needs manual image/logo replacement

- Main binary/vector brand assets: `icon.png`, `logo.svg`, and any final social/README preview assets that may be added later.
- Plymouth boot/decryption assets under `default/plymouth/`, especially `logo.png`, `logos/oma.png`, `lock.png`, `entry.png`, and progress images.
- SDDM login theme assets under `default/sddm/omarchy/`, especially `logo.png`, lock, entry, bullet, and failed-state images.
- Theme wallpapers named `omarchy.png`, `oma*.png`, or otherwise Omarchy-specific under `themes/*/backgrounds/`.
- Theme `preview.png`, `preview-unlock.png`, and `unlock.png` files after final Noctra wallpapers and lock assets are created.
- Chromium extension icon at `default/chromium/extensions/copy-url/icon.png` if it uses upstream Omarchy visual identity.

See `NOCTRA_ASSET_REPLACEMENT_REPORT.md` for the complete asset-by-asset replacement inventory and referencing files.

## Risky files not changed or only lightly changed

- `migrations/`: preserved to avoid invalidating historical update behavior.
- `default/pacman/`, `boot.sh` mirror selection, and `bin/omarchy-version-channel`: package/mirror infrastructure remains Omarchy-compatible until Noctra mirrors and package repositories exist.
- `bin/omarchy-reinstall-git`: still clones upstream Omarchy by default until a Noctra source repository URL is chosen.
- Lowercase command/path references (`omarchy`, `omarchy-*`, `$OMARCHY_PATH`, config/state paths) were preserved for compatibility.
- Binary image assets were not edited because no final Noctra logo, wallpaper, SDDM, Plymouth, or preview artwork was supplied.

## Recommended next steps

1. Create final Noctra visual assets: main logo, icon, wallpapers, Plymouth splash, SDDM login art, lock backgrounds, and previews.
2. Decide whether to keep `omarchy` command/path compatibility long-term or introduce `noctra` aliases/wrappers with a migration plan.
3. Configure Noctra-owned package repositories, mirrors, release pages, support URLs, and default Git clone repository.
4. Add a dedicated Noctra theme with purple/black cyber-minimal palette and make it the default after assets exist.
5. Review app IDs/window rules if moving from `org.omarchy` to a Noctra namespace.
6. Re-run the asset report after final artwork lands and remove remaining upstream visual identity.
