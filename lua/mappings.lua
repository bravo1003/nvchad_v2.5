require "nvchad.mappings"

local map = vim.keymap.set
-- Disabled

-- Defualt Telescope binding
map("n", "<leader>b", "<Nop>")
map("n", "<leader>fa", "<Nop>")
map("n", "<leader>fb", "<Nop>")
map("n", "<leader>ff", "<Nop>")
map("n", "<leader>fh", "<Nop>")
map("n", "<leader>fm", "<Nop>")
map("n", "<leader>fo", "<Nop>")
map("n", "<leader>fw", "<Nop>")
map("n", "<leader>fz", "<Nop>")
map("n", "<leader>ma", "<Nop>")
map("n", "<leader>gc", "<Nop>")
map("n", "<leader>gt", "<Nop>")
map("n", "<leader>ds", "<Nop>")
map("n", "<leader>ch", "<Nop>")
map("n", "<leader>cm", "<Nop>")
map("n", "<leader>pt", "<Nop>")
map("n", "<leader>th", "<Nop>")

-- Terminal
map("t", "<C-x>", "<Nop>")
map("n", "<leader>h", "<Nop>")
map("n", "<leader>v", "<Nop>")
map("n", "<leader>la", "<Nop>")
map("n", "<A-v>", "<Nop>")
map("n", "<A-h>", "<Nop>")
map("n", "<A-i>", "<Nop>")

-- NvimTree
map("n", "<C-n>", "<Nop>")
map("n", "<C-s>", "<Nop>")
map("n", "<C-c>", "<Nop>")
map("n", "Q", "<Nop>")
map("n", "gi", "<Nop>")

map("n", "<leader>n", "<Nop>")
map("n", "<leader>rh", "<Nop>")
map("n", "<leader>rn", "<Nop>")

map("i", "<C-b>", "<Nop>")

-- General
map("n", "<leader>rn", [[:%s/\<lt><C-R><C-W>\>/<C-R><C-W>/gI<Left><Left><Left>]], { desc = "Rename String" })
map("n", "<leader>nc", "<cmd> NvCheatsheet <CR>", { desc = "Mapping cheatsheet" })
map("n", ";", ":", { desc = "CMD enter command mode" })

map("i", "<C-a>", "<ESC>^i", { desc = "Beginning of line" })
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
map("n", "<leader>u", "<cmd> Telescope undo theme=ivy <cr>", { desc = "Telescope undo" })

--Gitsign
map("n", "<leader>gb", "<cmd> Git blame <cr>", { desc = "Git blame" })
map("n", "<leader>gf", "<cmd> Git reformat <cr>", { desc = "Git reformat (Vewd)" })

-- Hop
map("n", "<leader>h", "<cmd> HopWord <cr>", { desc = "Hop Word" })
map({ "n", "o" }, "<C-s>", function()
  require("tsht").nodes()
end, { desc = "TreeHopper Visual Selection" })

-- Lazygit
map("n", "<leader>gg", function()
  require("utils.lazygit").lazygit_toggle()
end, { desc = "Toggle Lazygit" })

map("n", "<leader>lf", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "Format" })
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
