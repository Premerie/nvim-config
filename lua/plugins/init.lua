return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2", -- It is highly recommended to use Harpoon 2
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("harpoon"):setup()
    end,
  },

  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require "dap"

      -- C / C++ / Rust Configuration (Using Termux GDB)
      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "-i", "mi" },
      }

      dap.configurations.c = {
        {
          name = "Launch GDB Engine",
          type = "gdb",
          request = "launch",
          program = function()
            -- Automatically targets your project's compiled makefile binary path
            return vim.fn.getcwd() .. "/bin/program"
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }

      -- Mirror C configuration properties over to Rust projects cleanly
      dap.configurations.rust = dap.configurations.c
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      local dap, dapui = require "dap", require "dapui"
      dapui.setup()

      -- Auto-open and close UI windows when debugging sessions start/end
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },

  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function()
      -- Path pointing directly to your Termux global python environment binary
      local python_path = "/data/data/com.termux/files/usr/bin/python"

      -- Load standard python launch behaviors
      require("dap-python").setup(python_path)

      -- Extend configurations to explicitly support Django applications
      local dap = require "dap"
      table.insert(dap.configurations.python, {
        type = "python",
        request = "launch",
        name = "Django Local Server",
        program = vim.fn.getcwd() .. "/manage.py", -- Dynamically targets manage.py in root
        args = { "runserver", "--noreload" }, -- Crucial: --noreload prevents threads from breaking breakpoints
      })
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "saadparwaiz1/cmp_luasnip", -- Connects luasnip directly to nvim-cmp
    },
    opts = function(_, opts)
      -- Insert luasnip into your active autocomplete sources list
      table.insert(opts.sources, { name = "luasnip" })
    end,
  },

  -- test new blink
  { import = "nvchad.blink.lazyspec" },

  {
    "L3MON4D3/LuaSnip",
    -- Follow the latest main releases
    version = "v2.*",
    -- This line compiles jsregexp on Termux automatically when the plugin installs or updates
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      -- Your standard Luasnip configuration goes here
      local luasnip = require "luasnip"

      -- Load global VSCode style snippets
      require("luasnip.loaders.from_vscode").lazy_load()

      -- Custom Framework Mappings
      luasnip.filetype_extend("typescriptreact", { "javascript", "typescript", "html" })
      luasnip.filetype_extend("python", { "django" })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "ts_ls",
        "eslint",
        "tailwindcss",
        "pyright",
        "python",
        "rust",
      },
      indent = { enable = true },
      auto_install = true,
    },
  },

  {
    "blazejkustra/react-compiler-marker",

    url = "https://github.com/blazejkustra/react-compiler-marker",
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    -- Bypasses the crashing vsce-sign post-install step on Termux
    build = "npm install --ignore-scripts",
    config = function()
      local base_path = vim.fn.stdpath "data" .. "/lazy/react-compiler-marker"
      vim.opt.rtp:append(base_path .. "/packages/nvim-client")

      local server_bin = base_path .. "/packages/server/dist/index.js"

      require("react-compiler-marker").setup {
        -- Visual settings
        emojis = {
          success = "✨", -- Successfully optimized
          error = "🚫", -- Failed to optimize
        },

        -- Inlay hint settings
        inlay_hints = {
          enabled = true,
          only_current_line = false,
          hide_in_insert_mode = true,
        },

        -- Auto-refresh settings
        auto_refresh = {
          on_save = true,
          on_text_change = true,
          debounce_ms = 300,
        },

        -- Keybindings (set to false to disable)
        keybindings = {
          check = "<leader>rcc", -- Check/refresh current file
          preview = "<leader>rcp", -- Preview compiled output
          status = "<leader>rcs", -- Show status
          toggle = "<leader>rct", -- Toggle activation
          refresh = "<leader>rr", -- Manual refresh (buffer-local)
        },

        -- Notifications
        notifications = {
          enabled = true,
          level = "info", -- "off", "error", "warn", "info"
        },

        -- LSP server settings
        server = {
          path = server_bin,
          node_path = "node",
        },

        -- Enable/disable on startup
        enabled = true,
        autostart = true,

        -- File types to attach to
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },

        -- Logging level
        log_level = "warn", -- "off", "error", "warn", "info", "debug", "trace"
      }
    end,
  },
}
