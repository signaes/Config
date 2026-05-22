return {
  "milanglacier/minuet-ai.nvim",
  config = function()
    require("minuet").setup({
      provider = "openai_fim_compatible",
      n_completions = 1,    -- recommended for local models
      context_window = 512, -- recommended for local models
      provider_options = {
        openai_fim_compatible = {
          api_key = "TERM",
          name = "Ollama",
          end_point = "http://localhost:11434/v1/completions",
          model = os.getenv("MINUET_OLLAMA_MODEL") or "qwen2.5-coder:7b",
          optional = {
            max_tokens = 256,
            top_p = 0.9,
          },
        },
      },
      virtualtext = {
        auto_trigger_ft = { "*" }, -- CRITICAL: enable for all filetypes
        keymap = {
          accept = "<C-y>",
          prev = "<C-p>",
          next = "<C-n>",
          dismiss = "<C-e>",
        },
      },
    })
  end,
}
