local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },

    -- Python (ruff is blazing fast, black is the classic fallback)
    python = { "ruff_format" },

    -- Go (goimports automatically fixes syntax and injects missing packages)
    go = { "goimports", "gofmt" },

    -- C & C++ (clang-format handles code structural design cleanly)
    c = { "clang-format" },
    cpp = { "clang-format" },

    -- Rust (rustfmt is the standard language toolkit optimizer)
    rust = { "rustfmt" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 1000,
    lsp_fallback = true,
  },
}

return options
