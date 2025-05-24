#!/bin/bash
set -e

SHEET_URL="https://docs.google.com/spreadsheets/d/1905ok69iJjK3ftajvnSEIc-sM-5YoDleR8REWsOza5g/export?format=csv"
TOOLS_DIR="$(cd "$(dirname "$0")" && pwd)"
BIN_PATH="$TOOLS_DIR/GenerateStrings"
TMP_DIR="/tmp/localization_build"
CSV_PATH="$TMP_DIR/localization.csv"
OUTPUT_DIR="$TMP_DIR/strings"

mkdir -p "$TMP_DIR"
mkdir -p "$OUTPUT_DIR"

echo "[INFO] Downloading CSV..."
curl -s -L "$SHEET_URL" -o "$CSV_PATH"

echo "[INFO] Running binary..."
"$BIN_PATH" "$CSV_PATH" "$OUTPUT_DIR"

echo "[INFO] Moving generated strings..."
cp -R "$OUTPUT_DIR"/* "$TOOLS_DIR/../Projects/UIComponent/Resources/Localization/"

echo "[✅] Done!"

