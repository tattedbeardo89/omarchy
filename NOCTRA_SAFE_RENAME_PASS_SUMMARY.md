# Noctra Safe Rename Pass Summary

## Scope

This pass applies the first safe user-facing rename layer for Noctra Hyprland Edition using `NOCTRA_SAFE_RENAME_REPORT.md` as the compatibility guardrail.

The pass intentionally limits changes to low-risk and medium-risk visible text. It preserves functional compatibility for the inherited `omarchy` command namespace, install/update paths, state directories, migrations, hooks, services, and package infrastructure.

## What was renamed or clarified

- Desktop/session visible names already present in this branch remain Noctra-branded: `default/wayland-sessions/omarchy.desktop` displays `Noctra Hyprland Edition` while retaining the inherited `omarchy.desktop` session file name for display-manager compatibility.
- SDDM visible metadata remains Noctra-branded: `default/sddm/omarchy/metadata.desktop` displays `Noctra Hyprland Edition` and `Noctra OS` while retaining the inherited `default/sddm/omarchy` theme path.
- Plymouth visible metadata remains Noctra-branded: `default/plymouth/omarchy.plymouth` displays `Noctra Hyprland Edition` while retaining the inherited Plymouth theme path and script names.
- Bootloader visible labels remain Noctra-branded: `default/limine/default.conf` uses `Noctra Hyprland Edition`, and `default/limine/limine.conf` uses `Noctra Bootloader`.
- Fastfetch visible OS branding remains Noctra-branded through `config/fastfetch/config.jsonc` and the install-time branding copy from `icon.txt`.
- GitHub issue-template user-facing text now says `Noctra Hyprland Edition` while preserving the inherited `omarchy-debug` compatibility command.
- The installed assistant skill documentation now describes the inherited `omarchy` CLI as the Noctra command center compatible with Omarchy command paths.
- The SDDM install comment was clarified to identify the visible Noctra theme while documenting that the inherited `omarchy` theme path is preserved.

## What was intentionally not renamed

- `bin/omarchy` and all `bin/omarchy-*` command files were not renamed.
- Internal `omarchy` command references inside scripts, Hyprland bindings, Waybar actions, Mako actions, hooks, desktop launchers, and helper configs were not renamed.
- `$OMARCHY_PATH`, `$OMARCHY_INSTALL`, `$OMARCHY_INSTALL_LOG_FILE`, `$OMARCHY_MIRROR`, `$OMARCHY_REPO`, and related environment variables were not renamed.
- `~/.local/share/omarchy`, `~/.config/omarchy`, and `~/.local/state/omarchy` paths were not renamed.
- `default/wayland-sessions/omarchy.desktop`, `default/sddm/omarchy`, and `default/plymouth/omarchy.*` file and directory names were not renamed because display-manager, SDDM, Plymouth, and install/update compatibility require a migration-first pass.
- Historical migrations were not modified.
- Omarchy attribution and MIT license notices in `LICENSE`, `NOTICE`, and attribution sections were left intact.
- Package names, mirror URLs, upstream repository defaults, keyring packages, and installer/update plumbing were left Omarchy-compatible until dedicated Noctra infrastructure exists.

## Remaining high/critical Omarchy identifiers

- Critical: `bin/omarchy`, `bin/omarchy-*`, command metadata keys, command aliases, and all script-invoked command paths.
- Critical: `$OMARCHY_PATH`, `$OMARCHY_INSTALL`, install log/state variables, and the installed source path `~/.local/share/omarchy`.
- Critical: migration history and migration state paths under `~/.local/state/omarchy/migrations`.
- High: `~/.config/omarchy` user config namespace, hooks, themes, extensions, and samples.
- High: systemd units and timers named `omarchy-*`.
- High: display/session, SDDM, Plymouth, Limine, pacman, mkinitcpio, sudoers, and udev filenames or units that include `omarchy` and require explicit migrations or service transition logic.
- High: package infrastructure names such as `omarchy-keyring`, `omarchy-nvim`, `omarchy-walker`, mirrors under `omarchy.org`, and the upstream `basecamp/omarchy` repository default.

## Compatibility aliases and paths preserved

- `omarchy` remains the primary installed CLI entry point for this pass.
- All `omarchy-*` helper commands remain available and unchanged.
- The Noctra command center wording explicitly documents compatibility with Omarchy command paths.
- The inherited `omarchy-debug` command remains referenced in bug-report guidance.
- Existing SDDM, Plymouth, Wayland session, systemd, hook, state, and config paths remain intact.

## Manual image/logo replacements still needed

Final bitmap artwork was not invented or replaced in this pass. A later visual-asset pass still needs dedicated Noctra artwork for:

- `default/sddm/omarchy/logo.png` and related SDDM image assets if the current images still carry upstream Omarchy identity.
- `default/plymouth/logo.png`, `default/plymouth/logos/oma.png`, previews, and related Plymouth image assets.
- Theme wallpapers named `omarchy.png` or otherwise likely Omarchy-specific under `themes/*/backgrounds/`.
- Generated theme `preview.png`, `preview-unlock.png`, and `unlock.png` files after final wallpaper/logo replacement.
- Any web-extension, application, or launcher icons that final Noctra visual guidelines choose to replace.

See `NOCTRA_ASSET_REPLACEMENT_REPORT.md` for the detailed asset inventory.
