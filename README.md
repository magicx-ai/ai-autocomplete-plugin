# AI Autocomplete for coding agents

This repository lets a coding agent set up and install AI Autocomplete in your project, through a conversation with AI Autocomplete's onboarding agent:

- the agent reads your code and sets up from what it finds;
- it asks you only what the code cannot answer, and once at the end whether to change anything;
- it uploads your data and installs the SDK.

You sign in once, in your browser. Your coding agent keeps the sign-in and renews it, so later runs start straight away.

It connects to AI Autocomplete's remote MCP server. There is nothing to install locally besides your coding agent.

> **Not released yet.** Production is not switched on, and both plugins here point at the development API (`https://dev-api.ai-autocomplete.com/api/agent-onboarding/mcp`). For internal testing, paste `Install AI Autocomplete using https://ikes-sandwiches.ai-autocomplete.com/agent-install.md` instead of the sentence below. It installs the `ai-autocomplete-dev` plugin, whose command is `/ai-autocomplete-dev:onboard`.

## Claude Code

Open Claude Code in your project and paste this:

```
Install AI Autocomplete using https://ai-autocomplete.com/agent-install.md
```

Claude installs the plugin and asks you to type two commands:

1. `/reload-plugins` loads the plugin into the session you are in.
2. `/ai-autocomplete:onboard` starts the onboarding.

Your browser opens for the sign-in: choose the team the product should belong to and approve. Claude waits for that and carries on by itself. To use another team later, sign in again.

Over SSH the browser cannot open on your side. Claude gives you the link instead; after approving, run `/ai-autocomplete:onboard` again.

### By hand

Install from a terminal, then start Claude Code and run `/ai-autocomplete:onboard`:

```bash
claude plugin install ai-autocomplete --marketplace magicx-ai/ai-autocomplete-plugin
```

Inside a session the same command works as `/plugin install ai-autocomplete --marketplace magicx-ai/ai-autocomplete-plugin`, followed by `/reload-plugins`. On older versions, run these two commands instead:

```
/plugin marketplace add magicx-ai/ai-autocomplete-plugin
/plugin install ai-autocomplete@ai-autocomplete
```

To sign in yourself, run `claude mcp login plugin:ai-autocomplete:ai-autocomplete`, or `/mcp` inside a session: select `ai-autocomplete` and authenticate.

### Approvals

Running `/ai-autocomplete:onboard` lets Claude work through the whole onboarding without asking you to approve each step. For the turn you start it in, the skill allows:

- AI Autocomplete's own tools;
- reading and editing files in your project (installing the SDK);
- shell commands (installing the package, starting your app to check the install, uploading your data file).

This is broad on purpose: the commands differ from project to project, so a short list would still stop on most of them. Nothing is committed, so `git diff` shows everything that changed. If you would rather approve each step, remove the `allowed-tools` line from the skill (`plugin/skills/onboard/SKILL.md` in the installed plugin).

The grant ends when you send your next message. When you answer the final question with a change, Claude asks before each step again unless your own settings allow it, for example in your project's `.claude/settings.json`:

```json
{
  "permissions": {
    "allow": ["mcp__plugin_ai-autocomplete_ai-autocomplete__*", "Edit", "Write", "Bash(npm install *)", "Bash(npm run *)"]
  }
}
```

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

1. The agent connects with the sign-in you already did. If you have not signed in, Claude Code opens the sign-in in your browser and waits for you to approve; Codex and Cursor tell you how to sign in and stop.
2. The agent reads your project and tells the onboarding agent what it found: the text box, what people do in it, each input and where its options live. It adds what you wrote with the command.
3. The onboarding agent sets everything up from that. It asks you only what the code cannot answer, such as whether a list should be uploaded or filled in by your app when both are possible.
4. If your data has to be uploaded, the agent uploads the file with a signed link. The file never goes into the conversation.
5. The agent installs the SDK, keeping your own input box, and checks that it still submits as before.
6. You get one summary of what was set up and one question: anything you want changed? The agent applies what you ask, checks the install again and ends the session.

## Development

`plugin-dev/` is generated from `plugin/`. After changing `plugin/`, run `scripts/sync-dev-plugin.sh`; CI fails when the two differ in anything but the name.
