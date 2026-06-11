# CodeCompanion Prompt Library

| Alias | Name | Type | Description |
|-------|------|------|-------------|
| `ocdev` | Opencode Architect | workflow | Configure/extend Opencode: agents, skills, MCP servers, permissions |
| `ccdev` | CodeCompanion Architect | workflow | Dogfooding: Extend CodeCompanion by searching its local source and docs |
| `research` | Research | workflow | Scope, investigate with tools, synthesize with sources and gaps flagged |
| `brainstorm` | Brainstorm Partner | chat | Divergent-first brainstorming partner with on-demand modes |
| `gdtestv` | GdUnit Test Generator (Agentic) | workflow | Write a GdUnit4 suite, run it, and loop until it passes |
| `gdtest` | GdUnit Test Generator | chat | Generate a GdUnit4 test suite for the current GDScript file |
| `example` | Zettelkasten Append Example | chat | Find relevant IWE note and append scratchpad work as an example |
| `bank` | Zettelkasten Problem Bank | chat | Generate a verified pool of practice problems into a note |
| `quiz` | Zettelkasten Quiz Tutor | chat | Quiz me on the practice problems in the current note |
| `zettel` | Zettelkasten Formatter | chat | Format study notes and autonomously save to IWE graph |

## Workflows

### Opencode Architect (`ocdev`)
- **Tools**: `run_command`, `grep_search`, `insert_edit_into_file`, `searxng`
- **MCP**: none
- Config at `~/.config/opencode/opencode.jsonc`

### CodeCompanion Architect (`ccdev`)
- **Tools**: `run_command`, `grep_search`, `insert_edit_into_file`, `searxng`
- **MCP**: none
- Source at `stdpath('data')/lazy/codecompanion.nvim`

### Research (`research`)
- **Tools**: `run_command`, `grep_search`, `insert_edit_into_file`, `searxng`
- **MCP**: `iwe`, `sequential_thinking`, `context`
- **Doc tracking**: Searches IWE doc-source notes ([[doc-sources-godot]], etc.) before deciding where to search

### GdUnit Test Generator Agentic (`gdtestv`)
- **Tools**: `insert_edit_into_file`, `run_command`
- **MCP**: none
- Loops: Write → Run → Fix until green

## Chats

### Brainstorm Partner (`brainstorm`)
- **Tools**: none
- **MCP**: none
- **Auto-submit**: false (waits for topic)

### GdUnit Test Generator (`gdtest`)
- **Tools**: `insert_edit_into_file`
- **MCP**: none
- **Modes**: visual, normal
- **Auto-submit**: true

### Zettelkasten Append Example (`example`)
- **Tools**: `insert_edit_into_file`
- **MCP**: `iwe`, `sequential_thinking`
- **Modes**: visual
- **Auto-submit**: true

### Zettelkasten Problem Bank (`bank`)
- **Tools**: none
- **MCP**: `iwe`
- Calls `iwe_iwe_retrieve` then `iwe_iwe_update`

### Zettelkasten Quiz Tutor (`quiz`)
- **Tools**: none
- **MCP**: none
- **Auto-submit**: true

### Zettelkasten Formatter (`zettel`)
- **Tools**: `insert_edit_into_file`
- **MCP**: none
- **Auto-submit**: true
- Dynamic dates via `date_context()`

## MCP Servers

| Name | Command |
|------|---------|
| `iwe` | `mcp-rtk -- cmd.exe /c cd /d C:/Users/mcraf/notes && iwec.exe` |
| `sequential_thinking` | `mcp-rtk -- .../mcp-server-sequential-thinking.cmd` |
| `playwright` | `mcp-rtk -- npx @playwright/mcp@latest --browser=firefox` |
| `context` | `mcp-rtk -- cmd.exe /c context serve` — local-first API docs (Godot 4.6, React, TypeScript, Tailwind at C:\Users\mcraf\.context\) |

## Adapters

| Name | Type | Command |
|------|------|---------|
| `opencode` | ACP | `~/.opencode/bin/opencode acp` — OpenCode Sisyphus AI orchestration platform |
| `deepseek` | HTTP | `api.deepseek.com` — DeepSeek v4 Flash (chat default) |
| `qwen` | HTTP | `localhost:8081` — Qwen 3.6 35B (openai_compatible) |

Select the `opencode` adapter in your chat buffer to use OpenCode's agent orchestration from within CodeCompanion.

## Custom Tools

| Name | Path | Params |
|------|------|--------|
| `searxng` | `custom.cc_searxng` | `query` (required), `engines`, `categories`, `language` (optional) |

SearXNG is the default web search (built-in `web_search` disabled). Use `engines="google,wikipedia"` or `categories="general,it"` for targeted searches. For Godot docs: `engines="google"`, `query="site:docs.godotengine.org <topic>"`.

## Slash Commands

| Name | Path | Description |
|------|------|-------------|
| `prune` | `custom.cc_dcp` | Drop duplicate and errored tool call pairs |

## IWE Template Notes

Template notes in the IWE graph that the LLM can reference via `iwe_find` + `iwe_retrieve`:

| Note | Purpose |
|------|---------|
| `doc-sources-godot` | Search strategy for Godot docs (searxng `site:` queries, context, rg) |
| `doc-sources-neovim` | Search strategy for Neovim docs (`:help`, searxng, rg plugin source) |
| `doc-sources-codecompanion` | Search strategy for CodeCompanion docs and source code |
| `error-solution-bank` | Hub note + template for capturing solved errors (searchable by code/version) |

LLM can `iwe_create` new notes following these templates — no separate prompt library entry needed.

## System Prompt

The system prompt (`interactions.chat.opts.system_prompt`) includes consolidated instructions for:
- **Documentation sources**: SearXNG (web, with engine/category filtering), context (MCP, local API docs), IWE doc-tracking notes
- **Error bank protocol**: When an error is solved, use `:CodeCompanion capture` to persist to `[[error-solution-bank]]`
- **IWE knowledge management**: Research and capture workflows, doc-source notes as reference

## Style Guide

- **Tool/MCP names** in prompt text: backticks `` `tool_name` ``
- **Workflow task prompts**: `@{tool_name}` template syntax
- **Section headers**: ALL CAPS
- **Numbered lists**: flush left, no leading spaces
