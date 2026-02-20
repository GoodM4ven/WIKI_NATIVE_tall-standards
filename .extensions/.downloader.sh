#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
EXTENSIONS_MD="$ROOT_DIR/codium-tall-extensions.md"
OUTPUT_DIR="$SCRIPT_DIR"

if [[ ! -f "$EXTENSIONS_MD" ]]; then
  echo "Missing file: $EXTENSIONS_MD" >&2
  exit 1
fi

if ! command -v npm >/dev/null 2>&1; then
  echo "npm is required but was not found in PATH." >&2
  exit 1
fi

read -r -p "Run npm install to install/update vsix-extension-manager first? [Y/n] " install_answer
if [[ -z "$install_answer" || "$install_answer" =~ ^[Yy]$ ]]; then
  (cd "$ROOT_DIR" && npm install)
fi

if ! (cd "$ROOT_DIR" && npx --no-install vsix-extension-manager --version >/dev/null 2>&1); then
  echo "vsix-extension-manager is not installed. Run npm install and try again." >&2
  exit 1
fi

mapfile -t extension_entries < <(
  awk '
    /^- \[/ {
      id = ""
      source = ""

      if (match($0, /\[([^]]+)\]/, id_match)) {
        id = id_match[1]
      }

      if (match($0, /\[\[(OpenVSX|Market)\]\(([^)]+)\)\]/, source_match)) {
        source = source_match[2]
      }

      if (id != "") {
        print id "\t" source
      }
    }
  ' "$EXTENSIONS_MD"
)

if [[ ${#extension_entries[@]} -eq 0 ]]; then
  echo "No extensions found in $EXTENSIONS_MD" >&2
  exit 1
fi

mkdir -p "$OUTPUT_DIR"
find "$OUTPUT_DIR" -type f -name '*.vsix' -delete

download_one() {
  local extension_input="$1"
  local source_hint="${2:-}"
  local output_file="$3"
  local -a cmd

  cmd=(
    npx --no-install vsix-extension-manager add "$extension_input"
    --download-only
    --output "$OUTPUT_DIR"
    --force
    --yes
    --quiet
  )

  if [[ -n "$source_hint" ]]; then
    cmd+=(--source "$source_hint")
  fi

  if (cd "$ROOT_DIR" && "${cmd[@]}") >"$output_file" 2>&1; then
    return 0
  fi

  return 1
}

attempted=0
downloaded=0
failed=0
declare -a failed_entries=()

for extension_entry in "${extension_entries[@]}"; do
  IFS=$'\t' read -r extension_id extension_source <<<"$extension_entry"
  [[ -z "$extension_id" ]] && continue

  attempted=$((attempted + 1))

  source_hint=""
  if [[ "$extension_source" == *"open-vsx.org"* ]]; then
    source_hint="open-vsx"
  elif [[ "$extension_source" == *"marketplace.visualstudio.com"* ]]; then
    source_hint="marketplace"
  fi

  log_file="$(mktemp)"

  if download_one "$extension_id" "$source_hint" "$log_file"; then
    downloaded=$((downloaded + 1))
    rm -f "$log_file"
    continue
  fi

  if [[ -n "$extension_source" ]] && download_one "$extension_source" "" "$log_file"; then
    downloaded=$((downloaded + 1))
    rm -f "$log_file"
    continue
  fi

  failed=$((failed + 1))
  failed_entries+=("$extension_id")
  echo "Failed: $extension_id" >&2
  tail -n 3 "$log_file" >&2 || true
  rm -f "$log_file"
done

echo "Downloaded $downloaded/$attempted extension(s) into $OUTPUT_DIR"

if [[ $failed -gt 0 ]]; then
  echo "" >&2
  echo "Could not download $failed extension(s):" >&2
  printf ' - %s\n' "${failed_entries[@]}" >&2
  exit 1
fi
