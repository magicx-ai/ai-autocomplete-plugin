# AI Autocomplete for coding agents

This repository lets a coding agent set up and install AI Autocomplete in your project, through a conversation with AI Autocomplete's onboarding agent:

- the agent answers what it can read from your code itself;
- it asks you only what it cannot read from the code;
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

## What happens

1. The agent calls `start_onboarding`, shows you a link and a code, and ends its turn. Open the link, check that the page shows the same code, approve, then tell the agent you approved.
2. The agent relays your answers to the onboarding agent. It answers code questions itself, such as which framework the app uses or where the search box is.
3. If your data has to be uploaded, the agent uploads the file with a signed link. The file never goes into the conversation.
4. Once the preview is ready, the agent installs the SDK, checks that your search box still submits as before, and ends the session.
