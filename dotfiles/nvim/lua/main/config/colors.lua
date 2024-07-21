local colorscheme = "tokyonight"

vim.g.tokyonight_style = "storm"
vim.g.tokyonight_italic_functions = true

local ok = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not ok then
  vim.notify_once("colorscheme " .. colorscheme .. " not found")
  return
end
