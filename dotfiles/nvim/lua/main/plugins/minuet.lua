local function is_ollama_running()
  local handle = io.popen("curl -s -o /dev/null -w '%{http_code}' http://localhost:11434/api/tags 2>/dev/null")
  if handle then
    local result = handle:read("*a")
    handle:close()
    return result == "200"
  end
  return false
end

return {
  "milanglacier/minuet-ai.nvim",
  config = function()
    if not is_ollama_running() then
      vim.notify("Ollama not running, minuet-ai disabled", vim.log.levels.WARN)
      return
    end

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
        auto_trigger_ft = {
          "lua", "python", "ruby", "javascript", "javascriptreact",
          "typescript", "typescriptreact", "go", "rust", "zig",
        }, -- explicit list: skip prose/markdown/picker buffers where AI FIM hurts more than helps
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
