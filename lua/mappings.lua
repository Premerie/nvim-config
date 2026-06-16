require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<leader>db", function()
  require("dap").toggle_breakpoint()
end, { desc = "Debug: Toggle Breakpoint" })

map("n", "<leader>dc", function()
  require("dap").continue()
end, { desc = "Debug: Start/Continue Session" })

map("n", "<leader>di", function()
  require("dap").step_into()
end, { desc = "Debug: Step Into" })

map("n", "<leader>do", function()
  require("dap").step_over()
end, { desc = "Debug: Step Over" })

map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Tap the ALT button on your extra-keys row, then drag your finger up/down to glide right/left
map({ "n", "v", "i" }, "<M-ScrollWheelDown>", "5zl", { desc = "Touch scroll right" })
map({ "n", "v", "i" }, "<M-ScrollWheelUp>", "5zh", { desc = "Touch scroll left" })

-- Add these to your mappings.lua if you want Ctrl+Up/Down:
map("n", "<C-Down>", ":move .+1<CR>==", { desc = "move line down" })
map("n", "<C-Up>", ":move .-2<CR>==", { desc = "move line up" })
