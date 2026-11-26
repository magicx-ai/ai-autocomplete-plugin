# Intent-1

Set up and install Intent-1 in your project through a conversation with its onboarding agent.

Intent-1 turns a search or chat box into one that suggests what to type next, from your own data. This plugin lets Claude do the setup with you:

- Claude reads your code and tells the onboarding agent what it found: the text box, what people do in it, and where each list of options lives.
- The onboarding agent sets everything up from that. It asks you only what the code cannot answer, and once at the end whether to change anything.
- Claude installs the SDK in your project and checks that the box still submits as before.

## Use it

Install the plugin from the Discover tab of `/plugin`, or from this repository with `/plugin install intent-1 --marketplace magicx-ai/intent-1-plugin`. Then open Claude Code in your project and run:

```
/intent-1:onboard
```

You can add what only you know, for example what the box should offer first or what it must never suggest:

```
/intent-1:onboard Start with "book a hotel" and "book a flight". Never suggest cruises.
```

Claude shows a sign-in link the first time. Choose the team the product should belong to and approve.

## What you need

- An Intent-1 account. The sign-in page lets you create one; plans are at https://magicx.ai/intent-1/other/pricing.
- Your project open in Claude Code, with the text box you want Intent-1 on.

## What the plugin does on your machine

- It connects to Intent-1's remote MCP server at `https://api.ai-autocomplete.com/api/agent-onboarding/mcp`. You sign in to it in your browser.
- Claude sends that server a description of your project's text box and inputs, and the instructions you wrote. A data file you choose to upload goes to Intent-1's storage through a signed link.
- Claude edits files in your project to install the SDK, and runs your project's own commands to install the package and start the app. Nothing is committed, so `git diff` shows every change.
- The plugin has no hooks, no local server and no scripts of its own.

Claude asks you to approve the Intent-1 tools, file edits and shell commands. Choosing the option that stops asking for the session keeps the setup moving.

## Privacy

- [Privacy policy](https://magicx.ai/intent-1/legal/privacy)
- [Terms of service](https://magicx.ai/intent-1/legal/terms)

## Help

Tell us through https://magicx.ai/intent-1, with what you typed and what Claude answered. Source: https://github.com/magicx-ai/intent-1-plugin
