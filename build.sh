#!/usr/bin/env bash
# STONED.md is the one source. This script wraps it into every door.
set -euo pipefail
cd "$(dirname "$0")"
SRC=STONED.md
body() { cat "$SRC"; }

# 1. Claude Code output style (forced on while the plugin is enabled)
{
  printf -- '---\nname: Stoned\ndescription: Explain It Like I'"'"'m Stoned — one idea at a time, re-anchored, with rails\nkeep-coding-instructions: true\nforce-for-plugin: true\n---\n\n'
  body
} > output-styles/stoned.md

# 2. Paste-anywhere prompt (any chat AI)
{
  printf 'Read this, then say "ok, what are we doing" and nothing else.\n\n'
  body
} > wrappers/paste-anywhere.txt

# 3. Custom GPT / Claude.ai project instructions (same text, no preamble)
body > wrappers/custom-gpt-instructions.md
body > wrappers/claude-project-instructions.md

# 4. Cursor rule (always on)
{
  printf -- '---\ndescription: Explain It Like I'"'"'m Stoned\nalwaysApply: true\n---\n\n'
  body
} > wrappers/cursor-stoned.mdc

# 5. AGENTS.md / CLAUDE.md snippet for any repo
{
  printf '# Explain It Like I'"'"'m Stoned\n\n'
  body
} > wrappers/AGENTS-snippet.md

echo "built from $SRC: output-styles/stoned.md + $(ls wrappers | wc -l) wrappers"
