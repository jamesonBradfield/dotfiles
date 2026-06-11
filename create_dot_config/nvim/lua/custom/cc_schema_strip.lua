-- Schema cruft stripper for CodeCompanion tool schemas.
--
-- Vibed advice, not researched. I have absolutely no schema knowledge when it
-- comes to LLMs, and vibe-coded cc_dcp because codecompanion didn't have it
-- natively. Same deal here: saw https://mnifzied-create.github.io/agentloop/token-tax/
-- and dropped in the strip() they suggested.
--
-- Strips three fields that carry zero tool-selection signal:
--   $schema              – JSON Schema version URL ("http://json-schema.org/...")
--   additionalProperties  – default behaviour, model doesn't use this
--   title                 – Pydantic auto-add; redundant with tool name
--
-- Operates recursively so nested object schemas are cleaned too.
-- Compact serialisation is NOT done here — the adapter's serialiser handles that.

local M = {}

local CRUFT = {
  ['$schema'] = true,
  ['additionalProperties'] = true,
  ['title'] = true,
}

---Recursively strip cruft keys from a table.
---Returns the same table, mutated in-place (zero-copy).
---@param t table
---@return table
function M.strip(t)
  if type(t) ~= 'table' then return t end

  -- Array branch
  if vim.islist(t) then
    for _, v in ipairs(t) do
      M.strip(v)
    end
    return t
  end

  -- Dict branch: remove cruft keys, recurse into values
  for k, _ in pairs(t) do
    if CRUFT[k] then
      t[k] = nil
    else
      M.strip(t[k])
    end
  end

  return t
end

return M
