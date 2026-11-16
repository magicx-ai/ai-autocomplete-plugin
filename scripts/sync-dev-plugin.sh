#!/usr/bin/env sh
# Writes plugin-dev/ from plugin/: the same plugin under the name ai-autocomplete-dev, pointing at the development API.
# With --check, fails when plugin-dev/ is not what this script would write.
set -eu
cd "$(dirname "$0")/.."

DEV_MCP_URL="https://dev-api.ai-autocomplete.com/api/agent-onboarding/mcp"

build() {
  rm -rf "$1"
  cp -R plugin "$1"
  sed -i.bak 's/"name": "ai-autocomplete"/"name": "ai-autocomplete-dev"/' "$1/.claude-plugin/plugin.json"
  sed -i.bak "s|\"url\": \"[^\"]*\"|\"url\": \"$DEV_MCP_URL\"|" "$1/.mcp.json"
  sed -i.bak 's/mcp__plugin_ai-autocomplete_ai-autocomplete__/mcp__plugin_ai-autocomplete-dev_ai-autocomplete__/' "$1/skills/onboard/SKILL.md"
  find "$1" -name '*.bak' -delete
}

if [ "${1:-}" = "--check" ]; then
  tmp=$(mktemp -d)
  trap 'rm -rf "$tmp"' EXIT
  build "$tmp/plugin-dev"
  diff -r "$tmp/plugin-dev" plugin-dev || { echo "plugin-dev/ is stale: run scripts/sync-dev-plugin.sh" >&2; exit 1; }
else
  build plugin-dev
fi
