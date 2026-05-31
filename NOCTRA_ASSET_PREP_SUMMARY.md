# Noctra Asset Prep Summary

## New folders created

- `assets/noctra/`
- `assets/noctra/logos/`
- `assets/noctra/wallpapers/`
- `assets/noctra/plymouth/`
- `assets/noctra/sddm/`
- `assets/noctra/icons/`
- `assets/noctra/screenshots/`
- `assets/noctra/boot/`

Each folder contains only a placeholder `.gitkeep` file. No artwork was generated, invented, or committed.

## Helper script behavior

`scripts/apply-noctra-assets.sh` copies final artwork from the `assets/noctra/` drop-in folders to the existing repository asset paths while preserving inherited Omarchy compatibility paths and filenames.

- Safe to run repeatedly.
- Prints `copied:` when it changes a file.
- Prints `unchanged:` when the destination already matches the drop-in asset.
- Warns and skips missing optional assets.
- Reports missing required assets.
- Fails for missing required assets only when `--strict` is passed.
- Does not require root because it copies only inside the repository.

Example:

```bash
scripts/apply-noctra-assets.sh
scripts/apply-noctra-assets.sh --strict
```

## Required assets still missing

Final Noctra artwork still needs to be supplied for:

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

Optional artwork can also be supplied for Plymouth progress assets, failed SDDM states, README screenshots, social previews, boot-menu placeholders, per-theme wallpaper overrides, terminal ASCII logos, and optional application icons.

## Visible areas that will change after assets are added

- Plymouth boot splash, encryption prompt, progress bar, and unlock preview.
- SDDM login logo and password-entry art.
- Hyprland theme wallpapers that currently use inherited `omarchy.png` slots.
- The square repository/extension icon and vector logo.
- Fastfetch/about/splash terminal branding if optional ASCII text files are supplied.
- README or web/social screenshots if those optional images are supplied and later referenced.

## Files intentionally left untouched

- Core `omarchy` commands and command aliases.
- Internal Omarchy paths, state directories, migration state, hooks, and systemd unit names.
- `default/sddm/omarchy` and `default/plymouth/omarchy.*` compatibility paths.
- Existing binary artwork, because final Noctra artwork was not provided.
- Historical migrations and package/mirror infrastructure.
- Third-party application icons unless a future Noctra icon-guideline pass explicitly replaces them.

See `NOCTRA_REQUIRED_ASSETS.md` for the full asset manifest and drop-in instructions.
