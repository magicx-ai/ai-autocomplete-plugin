#!/usr/bin/env bash
# Builds discover/skills/onboard/SKILL.md from plugin/skills/onboard/SKILL.md.
# The directory copy pre-approves read-only tools only. Pass --check to fail on drift.
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
source_skill="$root/plugin/skills/onboard/SKILL.md"
target_skill="$root/discover/skills/onboard/SKILL.md"
approvals_note='This copy of the skill does not approve tools ahead of time. Before your first tool call, tell the user in one line that Claude will ask them to approve the ai-autocomplete tools, file edits and shell commands, and that choosing the option that stops asking for the session keeps the setup moving.'

built="$(mktemp)"
trap 'rm -f "$built"' EXIT

awk '/^allowed-tools:/ { print "allowed-tools: Read, Grep, Glob, LS"; replaced = 1; next } { print } END { if (!replaced) exit 1 }' "$source_skill" > "$built"
printf '\n%s\n' "$approvals_note" >> "$built"

if [ "${1:-}" = "--check" ]; then
  if ! diff -u "$target_skill" "$built"; then
    echo "discover/skills/onboard/SKILL.md is out of date: run scripts/sync-discover.sh" >&2
    exit 1
  fi
  exit 0
fi

mkdir -p "$(dirname "$target_skill")"
cp "$built" "$target_skill"
