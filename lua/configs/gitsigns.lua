local options = {
  signs = {
    add = { text = "│" },
    change = { text = "│" },
    delete = { text = "󰍵" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
    untracked = { text = "│" },
  },

  preview_config = {
    -- Options passed to nvim_open_win
    border = "single",
  },

  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function opts(desc)
      return { buffer = bufnr, desc = desc }
    end

    local map = vim.keymap.set

    map("n", "gl", function()
      gs.blame_line()
    end, opts "Git blame line")
    map("n", "<leader>gj", function()
      gs.nav_hunk "next"
    end, opts "Next hunk")
    map("n", "<leader>gk", function()
      gs.nav_hunk "prev"
    end, opts "Previous hunk")
    map("n", "<leader>gR", function()
      gs.reset_buffer()
    end, opts "Reset buffer")
    map("n", "<leader>gb", function()
      gs.blame()
    end, opts "Git blame")
  end,
}

return options
