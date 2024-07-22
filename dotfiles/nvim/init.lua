local context = os.getenv("NEOVIM_CONFIG_CONTEXT") or "main"
local configs = { "options", "keymaps", "autocmd", "lazy", "colors" }

for _, config in ipairs(configs) do
  require(context .. ".config." .. config)
end
