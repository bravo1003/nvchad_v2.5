-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.hl.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- Troubel quickfix
vim.api.nvim_create_autocmd("BufRead", {
  callback = function(ev)
    if vim.bo[ev.buf].buftype == "quickfix" then
      vim.schedule(function()
        vim.cmd [[cclose]]
        vim.cmd [[Trouble qflist open]]
      end)
    end
  end,
})

--  Markdown, commit  spells checks
local spell_check_filetypes = { "markdown", "gitcommit" }
local augroup = vim.api.nvim_create_augroup("SpellCheckEnable", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  callback = function(_)
    if vim.tbl_contains(spell_check_filetypes, vim.bo.filetype) then
      -- Spell check
      vim.cmd [[ setlocal spell spelllang=en_us ]]
    end
  end,
  desc = "Disable spell check",
})
