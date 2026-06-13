vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "autocmds"

vim.schedule(function()
  require "mappings"
end)

vim.diagnostic.config {
  -- 1. Enable underlines for all diagnostic levels
  underline = true,

  -- 2. Disable standard virtual text at the end of the line (saves phone screen width)
  virtual_text = false,

  -- 3. Keep small icons/signs on the left gutter margin
  signs = true,

  -- 4. Update the layout behavior
  update_in_insert = false, -- Don't flash underlines while actively typing
  severity_sort = true, -- Prioritize showing errors over warnings
}

-- 5. Set underline styling overrides inside Neovim's highlight engine
-- This enforces specific styles (like undercurl or double lines) depending on your terminal terminal font capabilities
vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = "#db4b4b" }) -- Red Wave
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = "#e0af68" }) -- Yellow Wave
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { underline = true, sp = "#0db9d7" }) -- Blue Line
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { underline = true, sp = "#1abc9c" }) -- Teal Line
