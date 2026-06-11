local fmt = string.format
local log = require 'codecompanion.utils.log'

---@class CodeCompanion.Tool.SearXNG: CodeCompanion.Tools.Tool
return {
  name = 'searxng',
  cmds = {
    function(self, args, opts)
      local cb = opts.output_cb
      local query = args.query
      ---@type boolean
      local called = false

      local function safe_cb(msg)
        if called then return end
        called = true
        cb(msg)
      end

local cmd = {
        'rtk',
        'proxy',
        'curl',
        '-s',
        '-G',
        'http://localhost:8080/search',
        '--data-urlencode',
        'format=json',
        '--data-urlencode',
        'q=' .. query,
      }

      vim.fn.jobstart(cmd, {
        stdout_buffered = true,
        on_stdout = function(_, data)
          if not data or #data == 0 or (data[1] == '' and #data == 1) then return safe_cb { status = 'error', data = 'Empty response from SearXNG' } end
          local output = table.concat(data, '')
          local ok, json = pcall(vim.json.decode, output)
          if not ok or not json or not json.results then return safe_cb { status = 'error', data = 'Failed to parse SearXNG results' } end

          local results = {}
          for i, res in ipairs(json.results) do
            if i > 5 then break end
            table.insert(results, fmt('<attachment url="%s" title="%s">%s</attachment>', res.url, res.title, res.content or 'No snippet available'))
          end
          return safe_cb { status = 'success', data = table.concat(results, '\n') }
        end,
        on_stderr = function(_, data)
          if data and #data > 1 then log:error('[SearXNG Tool] curl error: ' .. table.concat(data, '\n')) end
        end,
        on_exit = function(_, exit_code)
          if not called then safe_cb { status = 'error', data = fmt('curl exited with code %d', exit_code) } end
        end,
      })
    end,
  },
  schema = {
    type = 'function',
    ['function'] = {
      name = 'searxng',
      description = 'Searches the web using a local SearXNG instance on port 8080. Use this for general web searches, documentation, or news.',
      parameters = {
        type = 'object',
        properties = {
          query = {
            type = 'string',
            description = 'The search query',
          },
        },
        required = { 'query' },
      },
    },
  },
  output = {
    ---@param self CodeCompanion.Tool.SearXNG
    ---@param stdout table The output from the command (a list of cmd outputs)
    ---@param meta { tools: CodeCompanion.Tools, cmd: table }
    success = function(self, stdout, meta)
      local chat = meta.tools.chat
      local content
      if type(stdout) == 'table' then
        if #stdout == 1 and type(stdout[1]) == 'string' then
          content = stdout[1]
        elseif #stdout == 1 and type(stdout[1]) == 'table' then
          local first_item = stdout[1]
          if type(first_item) == 'table' and first_item.content then
            content = first_item.content
          else
            content = vim.inspect(first_item)
          end
        else
          content = vim.iter(stdout):map(function(item)
            if type(item) == 'string' then return item
            elseif type(item) == 'table' and item.content then return item.content
            else return vim.inspect(item) end
          end):join('\n')
        end
      else
        content = tostring(stdout)
      end
      chat:add_tool_output(self, content, 'SearXNG results added to context')
    end,
    ---@param self CodeCompanion.Tool.SearXNG
    ---@param stderr table The error output from the command
    ---@param meta { tools: CodeCompanion.Tools, cmd: table }
    error = function(self, stderr, meta)
      local chat = meta.tools.chat
      local err_msg = type(stderr) == 'table' and vim.iter(stderr):flatten():join('\n') or tostring(stderr)
      chat:add_tool_output(self, 'Search failed: ' .. err_msg, 'SearXNG error')
    end,
  },
}
