require("nvchad.configs.lspconfig").defaults()

local configs = require "nvchad.configs.lspconfig"
local on_attach = configs.on_attach
local on_init = configs.on_init

-- Fetch blink.cmp's capability layer to enable auto-imports
local blink_capabilities = require("blink.cmp").get_lsp_capabilities()

-- Added "tailwindcss" to your active servers list
local servers = { "html", "cssls", "ts_ls", "pyright", "gopls", "tailwindcss" }
vim.lsp.enable(servers)

for _, lsp in ipairs(servers) do
  vim.lsp.config(lsp, {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = blink_capabilities, -- Uses blink instead of defaults
  })
end

vim.lsp.config("pyright", {
  settings = {
    python = {
      analysis = {
        indexing = true, -- Crucial for auto-import suggestions from unimported packages
        typeCheckingMode = "basic",
      },
    },
  },
})

vim.lsp.enable "pyright"

vim.lsp.config("rust_analyzer", {
  cmd = { "rust-analyzer" }, -- Forces your Termux native binary
  capabilities = blink_capabilities, -- Uses blink instead of defaults
  settings = {
    ["rust-analyzer"] = {
      rustc = {
        source = "discover",
      },
      cargo = {
        buildScripts = {
          enable = true,
        },
      },
      diagnostics = {
        enable = true,
      },
      inlayHints = {
        chainingHints = { enable = true },
        parameterHints = { enable = true },
        typeHints = { enable = true },
      },
    },
  },
})

-- Explicitly enable rust_analyzer to activate auto-start
vim.lsp.enable "rust_analyzer"

-- ====================================================================
-- Native C/C++ clangd Configuration for Termux
-- ====================================================================
vim.lsp.config("clangd", {
  cmd = {
    "clangd",
    "--clang-tidy", -- Activates deep bug linting using clang-tidy
    "--header-insertion=iwyu", -- Automatically inserts missing headers (Include What You Use)
    "--header-insertion-decorators", -- Adds visual indicator indicators in autocomplete menu
    "--completion-style=detailed", -- Shows function signatures in completion popups
    "--fallback-style=llvm", -- Default formatting if no local .clang-format file exists
  },
  capabilities = blink_capabilities, -- Connects autocomplete data stream to blink.cmp
  on_attach = on_attach,
  on_init = on_init,
})

-- Explicitly enable clangd to activate auto-start
vim.lsp.enable "clangd"
