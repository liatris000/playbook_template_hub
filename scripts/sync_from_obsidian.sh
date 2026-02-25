#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
MANIFEST_DEFAULT="$REPO_ROOT/sync/manifest.yaml"
MANIFEST_LOCAL="$REPO_ROOT/sync/manifest.local.yaml"
MANIFEST="$MANIFEST_DEFAULT"

if [[ -f "$MANIFEST_LOCAL" ]]; then
  MANIFEST="$MANIFEST_LOCAL"
fi

if [[ ! -f "$MANIFEST" ]]; then
  echo "manifest not found: $MANIFEST" >&2
  exit 1
fi

source_root="$(awk -F': ' '/^source_root:/ {print $2; exit}' "$MANIFEST" | tr -d '"')"
mappings_file_rel="$(awk -F': ' '/^mappings_file:/ {print $2; exit}' "$MANIFEST" | tr -d '"')"
mappings_file="$REPO_ROOT/$mappings_file_rel"

if [[ -z "$source_root" || ! -d "$source_root" ]]; then
  echo "source_root is missing or not found: $source_root" >&2
  echo "set source_root in $MANIFEST (or create $MANIFEST_LOCAL)" >&2
  exit 1
fi

if [[ ! -f "$mappings_file" ]]; then
  echo "mappings_file not found: $mappings_file" >&2
  exit 1
fi

echo "sync source: $source_root"
echo "sync mappings: $mappings_file"

while IFS='|' read -r from to type; do
  [[ -z "${from// }" ]] && continue
  [[ "${from:0:1}" == "#" ]] && continue

  src="$source_root/$from"
  dst="$REPO_ROOT/$to"

  if [[ ! -e "$src" ]]; then
    echo "skip (source missing): $src"
    continue
  fi

  if [[ "$type" == "dir" ]]; then
    mkdir -p "$dst"
    rsync -a \
      --exclude '.obsidian/' \
      --exclude '.DS_Store' \
      --exclude '_private/' \
      --exclude '**/_private/**' \
      "$src/" "$dst/"
    echo "synced dir: $from -> $to"
  elif [[ "$type" == "file" ]]; then
    mkdir -p "$(dirname "$dst")"
    cp "$src" "$dst"
    echo "synced file: $from -> $to"
  else
    echo "skip (unknown type=$type): $from"
  fi

done < "$mappings_file"

echo "sync completed"
