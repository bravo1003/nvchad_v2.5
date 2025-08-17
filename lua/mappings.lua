require "nvchad.mappings"

local map = vim.keymap.set
local del = vim.keymap.del
-- Disabled

-- Default Telescope binding
del("n", "<leader>b")
del("n", "<leader>fa")
del("n", "<leader>fb")
del("n", "<leader>ff")
del("n", "<leader>fh")
del("n", "<leader>fm")
del("v", "<leader>fm")
del("n", "<leader>fo")
del("n", "<leader>fw")
del("n", "<leader>fz")
del("n", "<leader>ma")
del("n", "<leader>gc")
del("n", "<leader>gt")
del("n", "<leader>ds")
del("n", "<leader>ch")
del("n", "<leader>cm")
del("n", "<leader>pt")
del("n", "<leader>th")

-- Terminal
del("t", "<C-x>")
del("n", "<leader>h")
del("n", "<leader>v")
del("n", "<A-v>")
del("n", "<A-h>")
del("n", "<A-i>")

-- NvimTree
del("n", "<leader>n")
del("n", "<leader>rn")
del("n", "<C-c>")
del("n", "<C-n>")
del("i", "<C-b>")

map("n", "Q", "<Nop>")
-- General
map("n", "<leader>rn", [[:%s/\<lt><C-R><C-W>\>/<C-R><C-W>/gI<Left><Left><Left>]], { desc = "Rename String" })
map("v", "<leader>rn", [[:s/\<lt><C-R><C-W>\>/<C-R><C-W>/gI<Left><Left><Left>]], { desc = "Rename String" })
map("n", "<leader>nc", "<cmd> NvCheatsheet <CR>", { desc = "Mapping cheatsheet" })

map("i", "<C-a>", "<ESC>^i", { desc = "Beginning_of_line" })
map("i", "<C-e>", "<End>", { desc = "End of line" })

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

map({ "n", "v" }, "x", [["_x]], { desc = "Delete void register" })
map("x", "p", [["_dP]], { desc = "Paste void register" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Visual move up", silent = true })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Visual move down", silent = true })
-- Float diagnostic
map("n", "<leader>f", function()
  vim.diagnostic.open_float { border = "rounded" }
end, { desc = "Float diagnostic" })

-- Telescope Undo
map("n", "<leader>u", function()
  Snacks.picker.undo()
end, { desc = "Snacks undo" })

-- tab close
map("n", "<leader>X", "<cmd> tabc <cr>", { desc = "tab close" })

--Gitsign
map("n", "<leader>gb", "<cmd> Gitsigns blame <cr>", { desc = "Git blame" })
map("n", "<leader>gf", "<cmd> Git cl format <cr>", { desc = "Git format (Xperi)" })

map("n", "<leader>nt", function()
  require("nvchad.themes").open()
end, { desc = "Theme Switcher" })
-- File browser
-- map("n", "<leader>e", "<cmd> NvimTreeToggle <cr>", { desc = "NvimTree Explorer toggle" })
map("n", "<leader>e", function()
  Snacks.explorer()
end, { desc = "File Explorer" })
-- map("n", "<C-y>", "<cmd> Yazi <cr>", { desc = "Open yazi file manager" })

map({"n", "t"}, "<C-\\>", function()
  Snacks.terminal()
end, { desc = "Terminal" })

-- Copy line without newline
map("n", "<leader>y", [[^y$]], { desc = "Yank no newline" })

-- Go to context
map("n", "<leader>cc", function()
  require("treesitter-context").go_to_context(vim.v.count1)
end, { desc = "Go to context" })
-- Hop
map("n", "<leader>h", "<cmd> HopWord <cr>", { desc = "Hop Word" })
map({ "n", "o" }, "<A-h>", function()
  require("tsht").nodes()
end, { desc = "TreeHopper Visual Selection" })

-- Lazygit
map("n", "<leader>gg", function()
  Snacks.lazygit()
end, { desc = "Toggle Lazygit" })

--Lsp
map({ "n", "v" }, "<leader>lf", function()
  require("conform").format { lsp_format = "fallback" }
end, { desc = "Format" })

map("n", "<leader>la", function()
  require("actions-preview").code_actions()
end, { desc = "Lsp Code Action" })

-- Dap
map("n", "<leader>dr", function()
  require("dap").continue()
  require("dapui").open()
end, { desc = "Start or Continue debugger" })
map("n", "<leader>dt", function()
  require("dapui").close()
  require("dap").terminate()
end, { desc = "Terminate debugger" })
map("n", "<leader>db", function()
  require("dap").toggle_breakpoint()
end, { desc = "Add breakpoint" })
map("n", "<leader>dB", function()
  require("dap").set_breakpoint(vim.fn.input "Condition: ")
end, { desc = "Add conditional breakpoint" })
map("n", "<F5>", function()
  require("dap").continue()
  require("dapui").open()
end, { desc = "Start or Continue debugger" })
map("n", "<F6>", function()
  require("dap").step_over()
end, { desc = "Step Over" })
map("n", "<F7>", function()
  require("dap").step_into()
end, { desc = "Step Into" })
map("n", "<F8>", function()
  require("dap").step_out()
end, { desc = "Step Out" })

-- Tmux navigator
map("n", "<C-h>", "<cmd> TmuxNavigateLeft <cr>", { desc = "Tmux navigate left" })
map("n", "<C-j>", "<cmd> TmuxNavigateDown <cr>", { desc = "Tmux navigate down" })
map("n", "<C-k>", "<cmd> TmuxNavigateUp <cr>", { desc = "Tmux navigate up" })
map("n", "<C-l>", "<cmd> TmuxNavigateRight <cr>", { desc = "Tmux navigate right" })
