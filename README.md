# AI Autocomplete for coding agents

This repository lets a coding agent set up and install AI Autocomplete in your project, through a conversation with AI Autocomplete's onboarding agent:

- the agent reads your code and sets up from what it finds;
- it asks you only what the code cannot answer, and once at the end whether to change anything;
- it uploads your data and installs the SDK.

You approve the connection once, in your browser.

It connects to AI Autocomplete's remote MCP server. There is nothing to install locally besides your coding agent.

> **This version points at the development API** (`https://dev-api.ai-autocomplete.com/api/agent-onboarding/mcp`), for internal testing.

## Claude Code

```bash
claude plugin install ai-autocomplete --marketplace magicx-ai/ai-autocomplete-plugin
```

Inside a session, the same command works as `/plugin install ai-autocomplete --marketplace magicx-ai/ai-autocomplete-plugin`. On older versions, run these two commands instead:

```
/plugin marketplace add magicx-ai/ai-autocomplete-plugin
/plugin install ai-autocomplete@ai-autocomplete
```

Then run `/ai-autocomplete:onboard` in your project, or ask Claude to onboard the project with AI Autocomplete.

## Codex

1. Add the server:

   ```bash
   codex mcp add ai-autocomplete --url https://dev-api.ai-autocomplete.com/api/agent-onboarding/mcp
   ```

   You can also paste [`codex/config.toml.example`](codex/config.toml.example) into `~/.codex/config.toml`. By default Codex asks before each MCP tool call; the example's `default_tools_approval_mode = "approve"` lets the onboarding tools run without asking.
2. Copy [`agents-skill/ai-autocomplete-onboard`](agents-skill/ai-autocomplete-onboard) to `.agents/skills/` in your project (or to `~/.agents/skills/`).
3. Run `$ai-autocomplete-onboard`, or ask Codex to onboard the project with AI Autocomplete.

## Cursor

1. Add the server to `.cursor/mcp.json` in your project (or to `~/.cursor/mcp.json`), as in [`cursor/mcp.json.example`](cursor/mcp.json.example).
2. Copy [`agents-skill/ai-autocomplete-onboard`](agents-skill/ai-autocomplete-onboard) to `.agents/skills/` in your project.
3. Run `/ai-autocomplete-onboard`, or ask the agent to onboard the project with AI Autocomplete.

## Say what only you know

The agent reads your code, so it does not ask where the search box is or which lists your app has. It cannot read what you want. Write that with the command and it is set up from the start:

```
/ai-autocomplete:onboard Start with "book a hotel", "book a flight" and "book a car". Never suggest cruises. Never ask for payment details.
```

Useful things to say: what the box should offer first, what it must never suggest, how suggestions should be written, and which parts of the app to cover. Without them the agent uses defaults and you can change them at the end.

## What happens

1. The agent calls `start_onboarding`, shows you a link and a code, and ends its turn. Open the link, check that the page shows the same code, approve, then tell the agent you approved.
2. The agent reads your project and tells the onboarding agent what it found: the text box, what people do in it, each input and where its options live. It adds what you wrote with the command.
3. The onboarding agent sets everything up from that. It asks you only what the code cannot answer, such as whether a list should be uploaded or filled in by your app when both are possible.
4. If your data has to be uploaded, the agent uploads the file with a signed link. The file never goes into the conversation.
5. The agent installs the SDK, keeping your own input box, and checks that it still submits as before.
6. You get one summary of what was set up and one question: anything you want changed? The agent applies what you ask, checks the install again and ends the session.
