return {
  'olimorris/codecompanion.nvim',
  branch = 'main',
  enabled = true,
  lazy = false,
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-treesitter/nvim-treesitter', 'ravitemer/codecompanion-history.nvim' },
  opts = {
    log_level = 'ERROR',

    voice = {
      enabled = true,
      auto_send = false,
    },

    adapters = {
      acp = {
        opencode = {
          name = 'opencode',
          formatted_name = 'OpenCode',
          type = 'acp',
          roles = {
            llm = 'assistant',
            user = 'user',
          },
          commands = {
            default = { 'opencode', 'acp' },
          },
          defaults = {
            mcpServers = {},
            timeout = 120000,
          },
          parameters = {
            protocolVersion = 1,
            clientCapabilities = {
              fs = { readTextFile = true, writeTextFile = true },
            },
            clientInfo = {
              name = 'CodeCompanion.nvim',
              version = '1.0.0',
            },
          },
          handlers = {
            setup = function(self)
              return true
            end,
            auth = function(self)
              return true
            end,
            form_messages = function(self, messages, capabilities)
              return require('codecompanion.adapters.acp.helpers').form_messages(self, messages, capabilities)
            end,
            on_exit = function(self, code) end,
          },
        },
      },
      http = {
        qwen = function()
          return require('codecompanion.adapters').extend('openai_compatible', {
            env = {
              url = 'http://127.0.0.1:8081',
              api_key = 'TERM',
            },
            name = 'qwen',
            formatted_name = 'Qwen 3.6 35B',
            schema = {
              model = {
                default = 'qwen3.6-35b-iq1',
              },
              max_tokens = {
                default = 8192,
              },
            },
            opts = {
              temperature = 0.7,
            },
          })
        end,
      },
    },

    context_management = {
      enabled = true,
      compaction = {
        trigger = 0.85,
        adapter = 'deepseek',
      },
    },

    -- Shared rule blocks for the one remaining inline prompt
    -- All other prompts live under lua/custom/prompts/ as markdown files.
    prompt_library = (function()
      local GDSCRIPT_RULES = [[
GODOT 4 / GDSCRIPT 2.0 RULES — target Godot 4.x. Reject Godot 3 idioms.

USE (Godot 4):
- Typed everything:  func move(dir: Vector2, speed: float) -> void:
- Annotations:       @export var speed: float = 200.0   @onready var spr: Sprite2D = $Sprite2D
- Signals:           signal died(score: int)            died.emit(score)
- Connect by Callable: enemy.died.connect(_on_enemy_died)
- Coroutines:        await get_tree().create_timer(1.0).timeout
- Unique nodes:      %HealthBar      Global class: class_name Player extends CharacterBody2D

FORBIDDEN (Godot 3 / GDScript 1.0 — never emit these):
- export(int) var x        -> use @export var x: int
- onready var n            -> use @onready var n
- setget setter, getter    -> use property syntax or explicit funcs
- yield(obj, "signal")     -> use await
- connect("died", self, "_on_died")  -> use died.connect(_on_died)
- emit_signal("died")      -> prefer died.emit()  (string form works but is legacy)

Prefer static typing on every var, param, and return. Untyped code is a defect.
]]
      local GDUNIT_RULES = [[
GDUNIT4 TEST SUITE RULES:
1. Structure: `class_name <Source>Test extends GdUnitTestSuite`. One `func test_*() -> void:` per behaviour.
2. Type-specific fluent assertions:
     assert_int(player.hp).is_equal(100)
     assert_str(name).is_not_empty().starts_with("Pl")
     assert_array(inv.items).contains([sword]).has_size(3)
     assert_object(node).is_not_null()
   Use assert_that(x) only when the type is genuinely unknown.
3. Any `.new()` Node/RefCounted -> wrap in auto_free() to avoid leaks.
4. Setup/teardown via before()/after()/before_test()/after_test() — never _init.
5. Cover nominal, boundary, and at least one edge/failure case per public function.
   Never write a test that only asserts the obvious (assert_int(1).is_equal(1)).
6. FILE PATHS: insert_edit_into_file writes to the OS filesystem and does NOT understand res://.
   Save the suite to an ABSOLUTE path: <project_root>/tests/test_<source_lowercase>.gd
   (derive <project_root> from the location of the file under test / where project.godot lives).
   res:// is ONLY valid for the GdUnit runner, which executes inside Godot.
7. Output only a one-line confirmation of the saved path. Do not paste the suite into chat.
]]
      return {
        ['GdUnit Test Generator (Agentic)'] = {
          interaction = 'workflow',
          description = 'Write a GdUnit4 suite, run it, and loop until it passes',
          opts = { alias = 'gdtestv' },
          tools = { 'insert_edit_into_file', 'run_command' },
          mcp_servers = 'none',
          prompts = {
            {
              {
                name = 'Write + Run',
                role = 'user',
                opts = { auto_submit = false },
                content = GDSCRIPT_RULES
                  .. GDUNIT_RULES
                  .. [[

TASK: Write a GdUnit4 test suite for the GDScript in #{buffer} using @{insert_edit_into_file} (absolute OS path — see rule 6).

Then run it with @{run_command} from the Godot project root:
  cd <project_root> && addons\gdUnit4\runtest.cmd -a res://tests
(res:// IS valid here — the runner executes inside Godot.)

The runner exits 0 even when it finds NO tests. A PASS means: at least one test executed AND zero failures. "No test suites found" is a FAILURE regardless of exit code — the runner is a liar.]],
              },
            },
            {
              {
                name = 'Fix until green',
                role = 'user',
                opts = { auto_submit = true },
                condition = function(chat) return chat.tools.tool and chat.tools.tool.name == 'run_command' end,
                content = [[If any test failed or none ran, fix the test suite or flag a real bug in the source, then re-run. Once a non-zero number of tests pass with zero failures, stop and give a 2-line summary.]],
              },
            },
          },
        },
        markdown = {
          dirs = {
            vim.fn.stdpath 'config' .. '/lua/custom/prompts',
          },
        },
      }
    end)(),

    interactions = {
      chat = {
        adapter = { name = 'opencode' },
        tools = {
          ['web_search'] = { enabled = false }, -- built-in requires TAVILY_API_KEY; use searxng instead
          ['searxng'] = {
            path = 'custom.cc_searxng',
            description = 'Search the web using a local SearXNG instance (port 8080)',
          },
        },
        slash_commands = {
          ['prune'] = {
            path = 'custom.cc_dcp',
            description = 'DCP: drop duplicate and errored tool call pairs (zero LLM cost)',
            opts = { contains_code = false },
          },
        },
        opts = {
          default_tools = { 'memory', 'searxng' },
          ---@param ctx CodeCompanion.SystemPrompt.Context
          system_prompt = function(ctx)
            return ctx.default_system_prompt
              .. string.format(
                [=[
Additional context:
All non-code text responses must be written in the %s language.
The user's current working directory is %s.
The current date is %s.
The user's Neovim version is %s.
The user is working on a %s machine. Please respond with system specific commands if applicable.

RESPONSE STYLE — this overrides any urge to be thorough:
- Lead with the answer or the code. No preamble ("Certainly", "Sure", "Great question"). Never restate my question back to me.
- Explain only when I ask why/how, or when a choice is genuinely non-obvious. Cap explanation at 1-3 sentences.
- No summary, recap, or "let me know if..." after a code block. Stop when the answer is complete.
- When editing existing code, output only the changed lines or a minimal diff — not the whole file unless I ask.
- If a request is ambiguous, ask ONE short clarifying question instead of guessing at length.
- Match my register: terse question gets a terse answer.

CODE BLOCKS:
- Open and close code blocks with four backticks, language ID after the opening backticks. Do not wrap the whole reply in one block.
- No line numbers or diff markers unless I ask.

TOOL USE DISCIPLINE:
- Do not search for files you have not been asked to find. Read only what you need; stop when you have enough context.
- Do not ask a clarifying question if the answer is inferable from context or common sense.
- If a task is clear, start it. Do not narrate a plan or ask for a "go-ahead".
- Do not re-read a file you just edited to verify — if the edit succeeded, it succeeded.
- No summaries after completing a task. Stop when the work is done.
- Prefix all run_command calls with `rtk` (e.g. `rtk cargo test`, `rtk git status`). RTK passes through unknown commands unchanged, so always use it.

USER PEDANTS — the user's non-negotiable architectural preferences:
- Godot: input polling (is_action_pressed, get_axis) belongs in _process or _unhandled_input, never in _physics_process. _physics_process reads state to apply forces; it does not determine state.
- Godot: prefer enum flags (bit-masked or per-state consts) when multiple states can be active simultaneously, so state determination can live in _process.

DOCUMENTATION SOURCES — use the right tool per task:
- @searxng for web searches (default). For Godot docs: engines="google", query="site:docs.godotengine.org <topic>". For Neovim: site:neovim.io/doc. For plugins: site:github.com. Use categories/engines params for precision.
- context (MCP server) for version-specific library API docs (installed: Godot 4.6, React, TypeScript, Tailwind). Use when SearXNG is too generic — context returns precise API refs from local .db index. Query: context query <package>@<version> "<topic>".
- iwe notes [[doc-sources-godot]], [[doc-sources-neovim]], [[doc-sources-codecompanion]] track the best search tool + strategy per topic. iwe_find these before guessing where to look.

KNOWLEDGE MANAGEMENT (iwe): Use :CodeCompanion research for iwe-powered investigation with memory search. Use :CodeCompanion capture after completing work. When you encounter an error: FIRST iwe_find the error code + tag "error-solution" to check [[error-solution-bank]] for known fixes. If found, apply and adapt. If not found, solve it → then persist the solution to [[error-solution-bank]] following its template (searchable by error code, version, and tags).
]=],
                ctx.language,
                ctx.cwd,
                ctx.date,
                ctx.nvim_version,
                ctx.os
              )
          end,
        },
      },
      cli = {
        agent = 'opencode',
        opts = {
          auto_insert = true,
        },
        agents = {
          opencode = {
            cmd = 'opencode',
            args = {},
            description = 'OpenCode TUI',
            provider = 'terminal',
          },
        },
      },
      inline = { adapter = { name = 'deepseek', model = 'deepseek-v4-flash', opts = { temperature = 0.7 } } },
    },
    mcp = {
      servers = {
        iwe = {
          cmd = { 'mcp-rtk', '--', 'cmd.exe', '/c', 'cd /d C:/Users/mcraf/notes && iwec.exe' },
        },
        sequential_thinking = {
          cmd = { 'mcp-rtk', '--', 'C:/Users/mcraf/AppData/Roaming/npm/mcp-server-sequential-thinking.cmd' },
        },
        playwright = {
          cmd = { 'mcp-rtk', '--', 'npx', '@playwright/mcp@latest', '--browser=firefox' },
        },
        context = {
          cmd = { 'mcp-rtk', '--', 'cmd.exe', '/c', 'context serve' },
        },
      },
      opts = { default_servers = { 'iwe', 'sequential_thinking' } },
    },
    display = { action_palette = { provider = 'mini_pick' } },
    extensions = {
      history = {
        enabled = true,
        opts = { dir_to_save = vim.fn.stdpath 'data' .. '/codecompanion_chats.json' },
      },
    },
    rules = {
      default = {
        files = {
          '.clinerules',
          '.cursorrules',
          '.goosehints',
          '.rules',
          '.windsurfrules',
          '.github/copilot-instructions.md',
          'AGENT.md',
          'AGENTS.md',
          { path = 'CLAUDE.md', parser = 'claude' },
          { path = 'CLAUDE.local.md', parser = 'claude' },
          -- Intentionally omitting '~/.claude/CLAUDE.md' to fix title hallucination
        },
      },
    },
  },
}
