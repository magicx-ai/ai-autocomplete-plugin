# AI Autocomplete for coding agents

This repository lets a coding agent set up and install AI Autocomplete in your project, through a conversation with AI Autocomplete's onboarding agent:

- the agent reads your code and sets up from what it finds;
- it asks you only what the code cannot answer, and once at the end whether to change anything;
- it uploads your data and installs the SDK.

You sign in once, in your browser. Your coding agent keeps the sign-in and renews it, so later runs start straight away.

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

Sign in once:

```bash
claude mcp login plugin:ai-autocomplete:ai-autocomplete
```

Inside a session, `/mcp` does the same: select `ai-autocomplete` and authenticate. Your browser opens; choose the team the product should belong to and approve. To use another team later, sign in again.

Then run `/ai-autocomplete:onboard` in your project, or ask Claude to onboard the project with AI Autocomplete.

### Approvals

The onboarding calls AI Autocomplete's tools many times. The skill lets Claude call them without asking you each time, for the turn you start it in. Editing your files and running commands (installing the SDK, starting your app to check the install) still follow your own permission settings: in the default mode Claude asks before each one.

To let it work through without stopping, start Claude in a mode that accepts edits (`claude --permission-mode acceptEdits`) or allow the commands it needs in your project's `.claude/settings.json`:

```json
{
  "permissions": {
    "allow": [
      "mcp__plugin_ai-autocomplete_ai-autocomplete__*",
      "Edit",
      "Write",
      "Bash(npm install *)",
      "Bash(npm run *)"
    ]
  }
}
```

The first rule also keeps the tools allowed after you answer the agent, when it applies a change you asked for.

## Codex

1. Add the server:

   ```bash
   codex mcp add ai-autocomplete --url https://dev-api.ai-autocomplete.com/api/agent-onboarding/mcp
   ```

   You can also paste [`codex/config.toml.example`](codex/config.toml.example) into `~/.codex/config.toml`. By default Codex asks before each MCP tool call; the example's `default_tools_approval_mode = "approve"` lets the onboarding tools run without asking.
2. Sign in once with `codex mcp login ai-autocomplete`, choosing your team in the browser.
3. Copy [`agents-skill/ai-autocomplete-onboard`](agents-skill/ai-autocomplete-onboard) to `.agents/skills/` in your project (or to `~/.agents/skills/`).
4. Run `$ai-autocomplete-onboard`, or ask Codex to onboard the project with AI Autocomplete.

## Cursor

1. Add the server to `.cursor/mcp.json` in your project (or to `~/.cursor/mcp.json`), as in [`cursor/mcp.json.example`](cursor/mcp.json.example).
2. Cursor shows the server as needing sign-in in its MCP settings; sign in there and choose your team in the browser.
3. Copy [`agents-skill/ai-autocomplete-onboard`](agents-skill/ai-autocomplete-onboard) to `.agents/skills/` in your project.
4. Run `/ai-autocomplete-onboard`, or ask the agent to onboard the project with AI Autocomplete.

## Say what only you know

The agent reads your code, so it does not ask where the search box is or which lists your app has. It cannot read what you want. Write that with the command and it is set up from the start:

```
/ai-autocomplete:onboard Start with "book a hotel", "book a flight" and "book a car". Never suggest cruises. Never ask for payment details.
```

Useful things to say: what the box should offer first, what it must never suggest, how suggestions should be written, and which parts of the app to cover. Without them the agent uses defaults and you can change them at the end.

## What happens

1. The agent connects with the sign-in you already did. If you have not signed in, it tells you how and stops.
2. The agent reads your project and tells the onboarding agent what it found: the text box, what people do in it, each input and where its options live. It adds what you wrote with the command.
3. The onboarding agent sets everything up from that. It asks you only what the code cannot answer, such as whether a list should be uploaded or filled in by your app when both are possible.
4. If your data has to be uploaded, the agent uploads the file with a signed link. The file never goes into the conversation.
5. The agent installs the SDK, keeping your own input box, and checks that it still submits as before.
6. You get one summary of what was set up and one question: anything you want changed? The agent applies what you ask, checks the install again and ends the session.
