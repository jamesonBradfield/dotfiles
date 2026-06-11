return {
  "milanglacier/minuet-ai.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local models = {}
    local file = io.open("C:/Users/mcraf/config.yaml", "r")
    if file then
      local in_models = false
      for line in file:lines() do
        if line:match("^models:") then
          in_models = true
        elseif in_models then
          local model_name = line:match('^%s+"([^"]+)":')
          if model_name then
            table.insert(models, model_name)
          elseif line:match("^%S") then
            in_models = false
          end
        end
      end
      file:close()
    end

    local modelcard = require("minuet.modelcard")
    if not modelcard.models.openai_fim_compatible then
      modelcard.models.openai_fim_compatible = {}
    end
    modelcard.models.openai_fim_compatible["llama-swap"] = models

    require("minuet").setup({
      provider = "openai_fim_compatible",
      n_completions = 1,
      context_window = 2048,
      request_timeout = 60,
      presets = {
        ["llama-swap"] = {
          provider_options = {
            openai_fim_compatible = {
              api_key = "TERM",
              name = "llama-swap",
              end_point = "http://127.0.0.1:8081/v1/completions",
              model = "qwen2.5-coder-godot-7b-q4",
              stream = true,
              optional = {
                max_tokens = 256,
                top_p = 0.9,
              },
            },
          },
        },
        deepseek = {
          provider_options = {
            openai_fim_compatible = {
              api_key = "DEEPSEEK_API_KEY",
              name = "Deepseek",
              end_point = "https://api.deepseek.com/beta/completions",
              model = "deepseek-coder",
              stream = true,
              optional = {
                max_tokens = 256,
                top_p = 0.9,
              },
            },
          },
        },
      },
      provider_options = {
        openai_fim_compatible = {
          api_key = "TERM",
          name = "llama-swap",
          end_point = "http://127.0.0.1:8081/v1/completions",
          model = "qwen2.5-coder-godot-7b-q4",
          stream = true,
          optional = {
            max_tokens = 256,
            top_p = 0.9,
          },
        },
      },
    })
  end,
}
