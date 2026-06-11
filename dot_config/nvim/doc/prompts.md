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
- **Tools**: `run_command`, `grep_search`, `insert_edit_into_file`
- **MCP**: `iwe`, `sequential_thinking`
- 3-step: Scope → Investigate → Report

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

## Custom Tools

| Name | Path |
|------|------|
| `searxng` | `custom.cc_searxng` |

## Slash Commands

| Name | Path | Description |
|------|------|-------------|
| `prune` | `custom.cc_dcp` | Drop duplicate and errored tool call pairs |

## Style Guide

- **Tool/MCP names** in prompt text: backticks `` `tool_name` ``
- **Workflow task prompts**: `@{tool_name}` template syntax
- **Section headers**: ALL CAPS
- **Numbered lists**: flush left, no leading spaces
