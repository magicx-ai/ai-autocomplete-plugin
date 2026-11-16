---
name: onboard
description: Set up and install AI Autocomplete in this project. Use when the user asks to onboard, add or install AI Autocomplete.
allowed-tools: mcp__plugin_ai-autocomplete-dev_ai-autocomplete__*, Read, Edit, Write, Bash
---

Onboard this project with AI Autocomplete. Use the ai-autocomplete MCP tools: call get_status first, then follow the guide it returns. If the server needs sign-in, start it yourself: call the server's authenticate tool, then open the link it returns in the user's browser with a shell command (`open` on macOS, `xdg-open` on Linux, `start` on Windows; quote the link). Do not end your turn there: the approvals this command grants end when the user sends another message. Wait in the same turn instead: run `sleep 10`, then try get_status, and repeat until it answers, for up to five minutes. If the browser cannot be opened (the shell command fails, or the session runs on another machine, as over SSH), no authenticate tool exists or the five minutes pass, end your turn with the link written out in full and these two cases: when the browser ends on a page that says the sign-in succeeded, the user runs this command again; when it ends on a localhost page that does not load, the user pastes that page's full address here, and you finish the sign-in with the server's complete_authentication tool and carry on.

The user may write instructions with the command: what the box should offer first, what it must never suggest, how suggestions should be written, or which parts of the app to cover. Put every such instruction, in the user's own words, in your first message to the onboarding agent, after what you read from the code. They are the user's decisions: never drop or reword one.
