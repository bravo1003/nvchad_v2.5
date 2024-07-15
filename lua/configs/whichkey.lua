local wk_ok, wk = pcall(require, "which-key")

if wk_ok then
  wk.add {
    { "<leader>c", group = "Context" },
    { "<leader>d", group = "Dap" },
    { "<leader>g", group = "Git" },
    { "<leader>l", group = "Lsp" },
    { "<leader>n", group = "NvChad" },
    { "<leader>r", group = "Rename" },
    { "<leader>s", group = "Search" },
    { "<leader>t", group = "Trouble" },
    { "<leader>w", group = "Whichkey" },
  }
end
