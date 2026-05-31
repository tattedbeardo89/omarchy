# Noctra Remaining User-Visible Branding Items

This file lists only items found in the installation, first-boot, first-login, or desktop-startup path that can be visible to a user and still reference Omarchy.

## Summary

Most primary first-boot branding surfaces now resolve to Noctra: installer banner, install progress logo, install completion logo, Limine branding, Plymouth artwork, SDDM artwork/metadata, session display name, wallpaper, lockscreen, Fastfetch OS text, and Waybar tooltip.

The remaining user-visible Omarchy items are mostly compatibility names surfaced in commands, paths, logs, or fallback infrastructure. The most important functional risk is the online bootstrap default repository.

## Items to address or consciously accept

| Priority | Item | Where visible | Current behavior | Recommendation |
| --- | --- | --- | --- | --- |
| Critical | Bootstrap repository default | Terminal during online install | `boot.sh` defaults `OMARCHY_REPO` to `basecamp/omarchy`, so a user who does not override it can clone and install upstream Omarchy instead of Noctra. The terminal message says it is cloning Noctra source, but the URL is upstream. | Change the default to the Noctra repository as soon as a canonical repository exists, or make `OMARCHY_REPO` mandatory for Noctra bootstrap. |
| High | Omarchy package mirror URLs | Terminal/logs during bootstrap and pacman setup, `/etc/pacman.d/mirrorlist` | `boot.sh` and pacman setup use `stable-mirror.omarchy.org`, `rc-mirror.omarchy.org`, or `mirror.omarchy.org`. Users can see these URLs in logs or pacman config. | Keep only if intentionally using upstream package infrastructure; otherwise replace with Noctra-owned mirror URLs. |
| Medium | Install log path and stage paths | Failure UI, support flow, `/var/log/omarchy-install.log` | The installer log file is `/var/log/omarchy-install.log`, and the failure UI can show scripts under `~/.local/share/omarchy/install/...`. | Accept as compatibility or add Noctra aliases/log paths in a later migration. |
| Medium | CLI namespace | Desktop shortcuts, Waybar actions, help output, terminal commands | User-facing commands are still `omarchy`, `omarchy-*`, and paths like `~/.config/omarchy`. The Waybar menu tooltip says `Noctra Menu`, but its click action runs `omarchy-menu`. | Accept for now if preserving Omarchy command compatibility; otherwise plan a separate CLI alias/rename migration. |
| Medium | SDDM/Plymouth theme directory names | Troubleshooting commands and config files | Visible artwork is Noctra, but theme internals remain `/usr/share/sddm/themes/omarchy`, `/usr/share/plymouth/themes/omarchy`, and SDDM `Current=omarchy`. | Accept as inherited internal identifiers unless users are expected to inspect theme settings. |
| Medium | Session file name and autologin session ID | SDDM config/troubleshooting | Visible session name is `Noctra Hyprland Edition`, but the file and autologin value are `omarchy.desktop` / `Session=omarchy`. | Accept for compatibility, or add a future `noctra.desktop` session while preserving `omarchy.desktop` as an alias. |
| Low | UKI name | Boot files / Limine tooling | `/etc/default/limine` sets `CUSTOM_UKI_NAME="omarchy"`. This may show in generated EFI/UKI filenames or maintenance output. | Consider changing to `noctra` only if compatible with upgrade/rollback expectations. |
| Low | Waybar custom module key and font name | Config inspection; possibly CSS/debug names | The module is named `custom/omarchy`, and the glyph font installed from `config/omarchy.ttf` is referenced as `font='omarchy'`; the visible tooltip is Noctra. | User-visible effect is Noctra, so this can be deferred until a broader namespace rename. |
| Low | Upstream changelog link | Update confirmation dialog | `bin/omarchy-update-confirm` says the changelog is the upstream Omarchy changelog until Noctra releases are published. | Replace when Noctra release notes exist. |
| Low | Migration messages on upgraded systems | Terminal/update logs, not fresh first install | Several old migrations echo Omarchy-branded messages. New installs mark migrations applied and normally do not display them, but upgraded systems can. | Only reword migrations that can still run for Noctra users and produce visible output. |

## Surfaces checked with no remaining visible Omarchy wordmark expected

- `boot.sh` ASCII banner: Noctra.
- `install/helpers/presentation.sh` install logo source: Noctra `logo.txt`.
- `install/helpers/errors.sh` fatal error headline: Noctra Hyprland Edition.
- `install/post-install/finished.sh` completion logo: Noctra `logo.txt`.
- `default/limine/limine.conf`: `Noctra Bootloader`.
- `default/limine/default.conf`: `TARGET_OS_NAME="Noctra Hyprland Edition"`.
- `default/sddm/omarchy/metadata.desktop`: `Name=Noctra Hyprland Edition`.
- `default/wayland-sessions/omarchy.desktop`: visible name `Noctra Hyprland Edition`.
- `config/fastfetch/config.jsonc`: OS command prints `Noctra Hyprland Edition $version`.
- `config/waybar/config.jsonc`: visible menu tooltip is `Noctra Menu`.
- `config/hypr/hyprlock.conf`: lockscreen points to Noctra asset path.

## Not counted as remaining user-visible branding

The following contain the string `omarchy`, but are not listed as remaining branding defects because they are inherited compatibility identifiers rather than a visible Omarchy wordmark on the default first boot:

- Repository install path: `~/.local/share/omarchy`.
- User config/state paths: `~/.config/omarchy`, `~/.local/state/omarchy`.
- Binary names: `bin/omarchy-*`.
- Command routes: `omarchy <group> <action>`.
- Internal theme names: `default/sddm/omarchy`, `default/plymouth/omarchy.*`.
- Package names inherited from upstream, such as `omarchy-nvim` and `omarchy-walker`.
