#!/bin/bash

set -euo pipefail

repo_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
asset_root="$repo_root/assets/noctra"
strict=false
missing=0
found=0

usage() {
  cat <<USAGE
Usage: scripts/apply-noctra-assets.sh [--strict]

Verify uploaded Noctra artwork in assets/noctra/ and print the runtime wiring
used by Plymouth, SDDM, Hyprlock, and the default wallpaper setup. This helper
intentionally does not create, replace, or copy image files.
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

check_asset() {
  local label=$1
  local rel=$2
  local requirement=${3:-required}

  if [[ -f $asset_root/$rel ]]; then
    echo "found: $label -> assets/noctra/$rel"
    ((found += 1))
    return 0
  fi

  if [[ $requirement == "required" ]]; then
    echo "missing: $label -> assets/noctra/$rel" >&2
    ((missing += 1))
  else
    echo "optional missing: $label -> assets/noctra/$rel"
  fi
}

check_asset "Plymouth logo" "plymouth/plymouth-logo.png"
check_asset "SDDM background" "sddm/sddm-background.png"
check_asset "Default wallpaper" "wallpapers/wallpaper.png"
check_asset "Hyprlock lockscreen" "wallpapers/lockscreen.png"
check_asset "Shared Noctra logo" "logos/noctra-logo.png"
check_asset "Legacy shared logo alias" "logos/logo.png" optional
check_asset "Fastfetch-specific logo" "logos/fastfetch-logo.png" optional
check_asset "Boot menu background" "boot/limine-background.png" optional
check_asset "Boot menu logo" "boot/boot-menu-logo.png" optional

echo
echo "Runtime wiring:"
echo "- Plymouth: bin/omarchy-refresh-plymouth copies assets/noctra/plymouth/plymouth-logo.png to the installed omarchy Plymouth theme logo paths."
echo "- SDDM: bin/omarchy-refresh-sddm copies assets/noctra/logos/noctra-logo.png and assets/noctra/sddm/sddm-background.png to the installed omarchy SDDM theme paths."
echo "- Hyprlock: config/hypr/hyprlock.conf references ~/.local/share/omarchy/assets/noctra/wallpapers/lockscreen.png."
echo "- Wallpaper: install/config/theme.sh sets the initial background to ~/.local/share/omarchy/assets/noctra/wallpapers/wallpaper.png when present."
echo "- Fastfetch: config/fastfetch/config.jsonc keeps text branding at ~/.config/omarchy/branding/about.txt."
echo "- Boot branding: default/limine/limine.conf keeps Noctra text branding; optional boot PNG assets are not referenced until uploaded and explicitly supported."

if [[ $strict == true ]] && ((missing > 0)); then
  echo "failed: $missing required asset(s) missing" >&2
  exit 1
fi

echo "summary: $found asset(s) found, $missing required asset(s) missing"
