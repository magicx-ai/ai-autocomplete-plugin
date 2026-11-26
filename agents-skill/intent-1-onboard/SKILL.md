---
name: intent-1-onboard
description: Set up and install Intent-1 (formerly AI Autocomplete) in this project. Use when the user asks to onboard, add or install Intent-1 or AI Autocomplete.
---

Onboard this project with Intent-1. Use the intent-1 MCP tools: call get_status first, then follow the guide it returns. If the tools are missing because the server needs sign-in, start the sign-in yourself when your client lets you. Where it has a tool or prompt that authenticates an MCP server, as Cursor does, use it for intent-1 and tell the user a sign-in window is opening: choose the team and approve. Where it has a sign-in command, as Codex does, run it with the shell tool in the background (`codex mcp login intent-1`), read the link it prints and give the user that link written out in full. Then end your turn with one line saying what they should do once they approve: carry on here if the tools appear, or start a new session and run this command again if the client loads a server's tools only when a session starts, as Codex does. Only in a client that gives you no way to start the sign-in, tell the user how to sign in with that client and stop.

The user may write instructions with the command: what the box should offer first, what it must never suggest, how suggestions should be written, or which parts of the app to cover. Put every such instruction, in the user's own words, in your first message to the onboarding agent, after what you read from the code. They are the user's decisions: never drop or reword one.
