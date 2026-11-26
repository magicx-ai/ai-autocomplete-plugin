# Intent-1 for coding agents

This repository lets a coding agent set up and install Intent-1 in your project, through a conversation with Intent-1's onboarding agent:

- the agent reads your code and sets up from what it finds;
- it asks you only what the code cannot answer, and once at the end whether to change anything;
- it uploads your data and installs the SDK.

You sign in once, in your browser. Your coding agent keeps the sign-in and renews it, so later runs start straight away.

It connects to Intent-1's remote MCP server. There is nothing to install locally besides your coding agent.

## What you need

- An Intent-1 account. The sign-in page lets you create one; plans are at https://magicx.ai/intent-1/other/pricing.
- A coding agent that connects to remote MCP servers with a browser sign-in: Claude Code, Codex or Cursor, in a current version.
- Your project open in that agent, with the text box you want Intent-1 on.

## Claude Code

Open Claude Code in your project and paste this:

```
Install Intent-1 using https://magicx.ai/agent-install.md
```

Claude installs the plugin and asks you to type two commands:

1. `/reload-plugins` loads the plugin into the session you are in.
2. `/intent-1:onboard` starts the onboarding.

Claude shows a sign-in link and opens it in your browser when it can: choose the team the product should belong to and approve. Claude carries on by itself once you approve. To use another team later, sign in again.

Over SSH, open the link yourself. If the browser ends on a localhost page that does not load, paste that page's full address into the session.

### By hand

Install from a terminal, then start Claude Code and run `/intent-1:onboard`:

```bash
claude plugin install intent-1 --marketplace magicx-ai/intent-1-plugin
```

Inside a session the same command works as `/plugin install intent-1 --marketplace magicx-ai/intent-1-plugin`, followed by `/reload-plugins`. On older versions, run these two commands instead:

```
/plugin marketplace add magicx-ai/intent-1-plugin
/plugin install intent-1@intent-1
```

To sign in yourself, run `claude mcp login plugin:intent-1:intent-1`, or `/mcp` inside a session: select `intent-1` and authenticate.

### Approvals

Running `/intent-1:onboard` lets Claude work through the whole onboarding without asking you to approve each step. For the turn you start it in, the skill allows:

- Intent-1's own tools;
- reading and editing files in your project (installing the SDK);
- shell commands (installing the package, starting your app to check the install, uploading your data file).

This is broad on purpose: the commands differ from project to project, so a short list would still stop on most of them. Nothing is committed, so `git diff` shows everything that changed. If you would rather approve each step, remove the `allowed-tools` line from the skill (`plugin/skills/onboard/SKILL.md` in the installed plugin).

The grant ends when you send your next message. When you answer the final question with a change, Claude asks before each step again unless your own settings allow it, for example in your project's `.claude/settings.json`:

```json
{
  "permissions": {
    "allow": ["mcp__plugin_intent-1_intent-1__*", "Edit", "Write", "Bash(npm install *)", "Bash(npm run *)"]
  }
}
```

### From Claude's plugin directory

The plugin in Claude's directory (the Discover tab of `/plugin`) is the same onboarding with one difference: it approves only read-only tools ahead of time, as the directory requires. Claude asks you to approve Intent-1's tools, file edits and shell commands as it goes. Installing with the sentence above gives you the version described under "Approvals".

## Codex

Open Codex in your project and paste this:

```
Install Intent-1 using https://magicx.ai/agent-install.md
```

Codex installs the plugin and starts the sign-in, asking you to approve the commands it runs. It then gives you two steps:

1. Open the sign-in link, choose the team the product should belong to and approve.
2. Start a new Codex session in the project and type `$intent-1:onboard`. A plugin installed while a session is running is loaded only by the next one.

### By hand

```bash
codex plugin marketplace add magicx-ai/intent-1-plugin
codex plugin add intent-1@intent-1
codex mcp login intent-1
```

Then start Codex in your project and run `$intent-1:onboard`, or ask Codex to onboard the project with Intent-1.

By default Codex asks before each MCP tool call. To let the onboarding tools run without asking, set `default_tools_approval_mode = "approve"` for the server, as in [`codex/config.toml.example`](codex/config.toml.example).

Without the plugin, add the server with `codex mcp add intent-1 --url https://api.ai-autocomplete.com/api/agent-onboarding/mcp`, copy [`agents-skill/intent-1-onboard`](agents-skill/intent-1-onboard) to `.agents/skills/` in your project (or to `~/.agents/skills/`), sign in as above and run `$intent-1-onboard`.

## Cursor

1. Add the server to `.cursor/mcp.json` in your project (or to `~/.cursor/mcp.json`), as in [`cursor/mcp.json.example`](cursor/mcp.json.example).
2. Cursor shows the server as needing sign-in in its MCP settings; sign in there and choose your team in the browser.
3. Copy [`agents-skill/intent-1-onboard`](agents-skill/intent-1-onboard) to `.agents/skills/` in your project.
4. Run `/intent-1-onboard`, or ask the agent to onboard the project with Intent-1.

## Say what only you know

The agent reads your code, so it does not ask where the search box is or which lists your app has. It cannot read what you want. Write that with the command and it is set up from the start:

```
/intent-1:onboard Start with "book a hotel", "book a flight" and "book a car". Never suggest cruises. Never ask for payment details.
```

Useful things to say: what the box should offer first, what it must never suggest, how suggestions should be written, and which parts of the app to cover. Without them the agent uses defaults and you can change them at the end.

## What happens

1. The agent connects with the sign-in you already did. If you have not signed in, the agent starts the sign-in where its client lets it: Claude Code opens it in your browser and carries on once you approve, and Codex shows a link and asks you to start a new session afterwards. Where the client gives the agent no way to start it, the agent tells you how to sign in and stops.
2. The agent reads your project and tells the onboarding agent what it found: the text box, what people do in it, each input and where its options live. It adds what you wrote with the command.
3. The onboarding agent sets everything up from that. It asks you only what the code cannot answer, such as whether a list should be uploaded or filled in by your app when both are possible.
4. If your data has to be uploaded, the agent uploads the file with a signed link. The file never goes into the conversation.
5. The agent installs the SDK. By default Intent-1's box takes the place of your input box and keeps its look; say so if you would rather keep your own box and add only the suggestions. The agent then checks that the box still submits as before.
6. You get one summary of what was set up and one question: anything you want changed? The agent applies what you ask, checks the install again and ends the session.

## If something goes wrong

- The install command fails: check that `claude plugin install` runs in your terminal and that your Claude Code is up to date, then use the steps under "By hand".
- The sign-in does not finish: run `/mcp`, select `intent-1` and authenticate again.
- Anything else: tell us through https://magicx.ai/intent-1, with what you typed and what the agent answered.

## Moving from the ai-autocomplete plugin

Intent-1 used to be called AI Autocomplete, and this plugin used to be `ai-autocomplete`. A plugin installed under the old name gets no more updates. To switch, remove it and install `intent-1`. You sign in once more, because the sign-in is stored under the server's old name.

In Claude Code:

```bash
claude plugin uninstall ai-autocomplete@ai-autocomplete
claude plugin marketplace remove ai-autocomplete
claude plugin install intent-1 --marketplace magicx-ai/intent-1-plugin
```

In Codex:

```bash
codex plugin remove ai-autocomplete@ai-autocomplete
codex plugin marketplace remove ai-autocomplete
codex plugin marketplace add magicx-ai/intent-1-plugin
codex plugin add intent-1@intent-1
codex mcp login intent-1
```

## For maintainers

The repository holds the plugin twice, because the two ways of installing it allow different approvals:

- [`plugin/`](plugin) is what this repository's own marketplace installs (`.claude-plugin/marketplace.json`). Its skill approves the onboarding's tools ahead of time.
- [`discover/`](discover) is what Claude's plugin directory lists. Its skill approves read-only tools only. It carries its own `plugin.json`, `.mcp.json` and README, and it is not in this repository's marketplace.

Edit the skill in `plugin/` only, then run `scripts/sync-discover.sh` to rebuild the copy in `discover/`. CI fails when the two differ. Raise `version` in `discover/.claude-plugin/plugin.json` with every change to `discover/`: the directory publishes a new version only when it changes.

## License

Apache-2.0. See [LICENSE](LICENSE).
