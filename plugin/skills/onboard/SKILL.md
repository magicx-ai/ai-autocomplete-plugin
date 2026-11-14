---
name: onboard
description: Set up and install AI Autocomplete in this project. Use when the user asks to onboard, add or install AI Autocomplete.
allowed-tools: mcp__plugin_ai-autocomplete_ai-autocomplete__*
---

Onboard this project with AI Autocomplete. Use the ai-autocomplete MCP tools: call get_status first, then follow the guide it returns. If the tools are missing because the server needs sign-in, tell the user how to sign in with their client and stop; you cannot sign in for them.

The user may write instructions with the command: what the box should offer first, what it must never suggest, how suggestions should be written, or which parts of the app to cover. Put every such instruction, in the user's own words, in your first message to the onboarding agent, after what you read from the code. They are the user's decisions: never drop or reword one.
