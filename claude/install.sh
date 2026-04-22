#!/usr/bin/env bash
# Install Claude Code statusline script and wire it into settings.json.

CLAUDE_DIR="$HOME/.claude"
SCRIPT_SRC="$(cd "$(dirname "$0")" && pwd)/statusline.sh"
SCRIPT_DST="$CLAUDE_DIR/statusline.sh"
SETTINGS="$CLAUDE_DIR/settings.json"

mkdir -p "$CLAUDE_DIR"

ln -sf "$SCRIPT_SRC" "$SCRIPT_DST"
echo "Claude statusline script linked."

if [ ! -f "$SETTINGS" ]; then
  echo "{}" > "$SETTINGS"
fi

if command -v jq &>/dev/null; then
  tmp=$(mktemp)
  jq --arg cmd "bash \"$SCRIPT_DST\"" \
    '.statusLine = {"type": "command", "command": $cmd}' \
    "$SETTINGS" > "$tmp" && mv "$tmp" "$SETTINGS"
  echo "Claude statusLine wired in settings.json."
else
  echo "jq not found — manually add to $SETTINGS:"
  echo "  \"statusLine\": { \"type\": \"command\", \"command\": \"bash \\\"$SCRIPT_DST\\\"\" }"
fi
