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

Copy uploaded Noctra artwork from assets/noctra/ into the existing repository
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

copy_first_existing() {
  local dest_rel=$1
  local requirement=$2
  shift 2
  local source_rel

  for source_rel in "$@"; do
    if [[ -f $asset_root/$source_rel ]]; then
      copy_asset "$source_rel" "$dest_rel" "$requirement"
      return 0
    fi
  done

  if [[ $requirement == "required" ]]; then
    mark_missing_required "$1" "$dest_rel"
  else
    warn "missing optional asset candidates for $dest_rel: $*"
  fi
}

copy_wallpaper() {
  local dest_rel=$1
  copy_first_existing "$dest_rel" required \
    "wallpapers/wallpaper.png" \
    "wallpapers/noctra-wallpaper2.png"
}

copy_lockscreen() {
  local dest_rel=$1
  copy_first_existing "$dest_rel" required \
    "wallpapers/lockscreen.png" \
    "wallpapers/noctra-lockscreen2.png" \
    "wallpapers/wallpaper.png"
}

copy_first_existing "default/plymouth/logo.png" required \
  "plymouth/plymouth-logo.png" \
  "plymouth/logo.png" \
  "logos/logo.png" \
  "logos/noctra-logo.png"
copy_first_existing "default/plymouth/logos/oma.png" optional \
  "plymouth/plymouth-logo.png" \
  "plymouth/oma.png" \
  "logos/logo.png" \
  "logos/noctra-logo.png"

copy_first_existing "default/sddm/omarchy/logo.png" required \
  "logos/logo.png" \
  "logos/noctra-logo.png" \
  "plymouth/plymouth-logo.png"
copy_first_existing "default/sddm/omarchy/background.png" required \
  "sddm/sddm-background.png" \
  "wallpapers/lockscreen.png" \
  "wallpapers/wallpaper.png"

copy_wallpaper "themes/tokyo-night/backgrounds/0-noctra.png"
copy_wallpaper "themes/tokyo-night/backgrounds/omarchy.png"
copy_lockscreen "themes/tokyo-night/backgrounds/lockscreen.png"

while IFS= read -r -d '' theme_background; do
  dest_rel=${theme_background#"$repo_root/"}
  [[ $dest_rel == "themes/tokyo-night/backgrounds/omarchy.png" ]] && continue
  copy_wallpaper "$dest_rel"
done < <(find "$repo_root/themes" -path '*/backgrounds/*omarchy*.png' -type f -print0 | sort -z)

copy_first_existing "logo.png" optional \
  "logos/logo.png" \
  "logos/noctra-logo.png"
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
