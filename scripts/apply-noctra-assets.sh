#!/bin/bash

set -euo pipefail

repo_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
asset_root="$repo_root/assets/noctra"
strict=false
changed=0
warnings=0
missing_required=0
declare -A missing_required_seen=()

usage() {
  cat <<USAGE
Usage: scripts/apply-noctra-assets.sh [--strict]

Copy prepared Noctra artwork from assets/noctra/ into the existing repository
asset paths. Missing optional files are reported and skipped. Missing required
files fail only when --strict is passed.
USAGE
}

while (($# > 0)); do
  case "$1" in
    --strict)
      strict=true
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "error: unknown option: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
  shift
done

warn() {
  echo "warning: $*" >&2
  ((warnings += 1))
}

mark_missing_required() {
  local source_rel=$1
  local dest_rel=$2

  warn "missing required asset assets/noctra/$source_rel for $dest_rel"
  if [[ -z ${missing_required_seen[$source_rel]+set} ]]; then
    missing_required_seen[$source_rel]=1
    ((missing_required += 1))
  fi
}

copy_asset() {
  local source_rel=$1
  local dest_rel=$2
  local requirement=${3:-optional}
  local source="$asset_root/$source_rel"
  local dest="$repo_root/$dest_rel"

  if [[ ! -f $source ]]; then
    if [[ $requirement == "required" ]]; then
      mark_missing_required "$source_rel" "$dest_rel"
    else
      warn "missing optional asset assets/noctra/$source_rel; skipping $dest_rel"
    fi
    return 0
  fi

  mkdir -p "$(dirname -- "$dest")"
  if [[ -f $dest ]] && cmp -s "$source" "$dest"; then
    echo "unchanged: $dest_rel"
    return 0
  fi

  cp "$source" "$dest"
  echo "copied: assets/noctra/$source_rel -> $dest_rel"
  ((changed += 1))
}

copy_wallpaper() {
  local theme=$1
  local dest_rel=$2
  local theme_source="$asset_root/wallpapers/$theme.png"
  local fallback_source="$asset_root/wallpapers/noctra-4k.png"

  if [[ -f $theme_source ]]; then
    copy_asset "wallpapers/$theme.png" "$dest_rel" optional
  elif [[ -f $fallback_source ]]; then
    copy_asset "wallpapers/noctra-4k.png" "$dest_rel" required
  else
    mark_missing_required "wallpapers/noctra-4k.png" "$dest_rel"
  fi
}

copy_asset "logos/noctra-logo.svg" "logo.svg" required
copy_asset "logos/noctra-icon.png" "icon.png" required
copy_asset "logos/noctra-icon.png" "default/chromium/extensions/copy-url/icon.png" required
copy_asset "logos/noctra-terminal-logo.txt" "logo.txt" optional
copy_asset "logos/noctra-fastfetch-about.txt" "icon.txt" optional

copy_asset "plymouth/logo.png" "default/plymouth/logo.png" required
copy_asset "plymouth/oma.png" "default/plymouth/logos/oma.png" optional
copy_asset "plymouth/bullet.png" "default/plymouth/bullet.png" required
copy_asset "plymouth/entry.png" "default/plymouth/entry.png" required
copy_asset "plymouth/lock.png" "default/plymouth/lock.png" required
copy_asset "plymouth/progress_bar.png" "default/plymouth/progress_bar.png" optional
copy_asset "plymouth/progress_box.png" "default/plymouth/progress_box.png" optional
copy_asset "plymouth/preview-unlock.png" "default/plymouth/preview-unlock.png" optional

copy_asset "sddm/logo.png" "default/sddm/omarchy/logo.png" required
copy_asset "sddm/bullet.png" "default/sddm/omarchy/bullet.png" required
copy_asset "sddm/entry.png" "default/sddm/omarchy/entry.png" required
copy_asset "sddm/entry-failed.png" "default/sddm/omarchy/entry-failed.png" optional
copy_asset "sddm/lock.png" "default/sddm/omarchy/lock.png" required
copy_asset "sddm/lock-failed.png" "default/sddm/omarchy/lock-failed.png" optional

while IFS= read -r wallpaper_dest; do
  theme=${wallpaper_dest#themes/}
  theme=${theme%%/*}
  copy_wallpaper "$theme" "$wallpaper_dest"
done < <(find "$repo_root/themes" -path '*/backgrounds/omarchy.png' -type f -printf '%P\n' | sed 's#^#themes/#' | sort)

copy_wallpaper "flexoki-light" "themes/flexoki-light/backgrounds/2-omarchy.png"

for screenshot_dest in README.png README-dark.png README-terminal.png README-installer.png README-lock.png; do
  copy_asset "screenshots/$screenshot_dest" "$screenshot_dest" optional
done

for boot_dest in grub-background.png limine-background.png boot-menu-logo.png; do
  copy_asset "boot/$boot_dest" "$boot_dest" optional
done

if [[ $strict == true ]] && ((missing_required > 0)); then
  echo "failed: $missing_required required asset(s) missing; no more changes can be guaranteed" >&2
  exit 1
fi

echo "summary: $changed file(s) copied, $warnings warning(s), $missing_required required asset(s) missing"
