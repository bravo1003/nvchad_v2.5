local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "bash",
    "c",
    "cpp",
    "rust",
    "go",
    "dockerfile",
    "devicetree",
    "markdown",
    "markdown_inline",
    "regex",
    "python",
    "query",
  },
  indent = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      scope_incremental = "<TAB>",
      node_incremental = "<CR>",
      node_decremental = "<BS>",
    },
    is_supported = function()
      local mode = vim.api.nvim_get_mode().mode
      if mode == "c" then
        return false
      end
      return true
    end,
  },
  -- textsubjects = {
  --   enable = true,
  --   prev_selection = "<S-tab>",
  --   keymaps = {
  --     ["<cr>"] = "textsubjects-smart",
  --     [";"] = "textsubjects-container-outer",
  --     ["i;"] = "textsubjects-container-inner",
  --   },
  -- },
  textobjects = {
    swap = {
      enable = true,
      swap_next = {
        ["<leader>ca"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>cA"] = "@parameter.inner",
      },
    },
  },
}

M.telescope = {
  defaults = {
    winblend = 8,
    selection_caret = " ",
    path_display = { "smart" },
    mappings = {
      i = {
        ["<c-t>"] = function(bufnr)
          require("trouble.sources.telescope").open(bufnr)
        end,
      },
      n = {
        ["<c-t>"] = function(bufnr)
          require("trouble.sources.telescope").open(bufnr)
        end,
      },
    },
  },

  pickers = {
    find_files = {
      find_command = {
        "fd",
        "--type",
        "f",
        "--color",
        "never",
      },
      follow = true,
    },
  },
  extensions = {
    live_grep_args = {
      auto_quoting = true, -- enable/disable auto-quoting
      -- define mappings, e.g.
      mappings = { -- extend mappings
        i = {
          ["<C-k>"] = function (bufnr)
            require("telescope-live-grep-args.actions").quote_prompt { postfix = " -t" }(bufnr)
          end,
          -- freeze the current list and start a fuzzy search in the frozen list,
          ["<C-space>"] = function (bufnr)
            require("telescope-live-grep-args.actions").to_fuzzy_refine(bufnr)
          end
        },
      },
    },
    -- no other extensions here, they can have their own spec too
  },
  extensions_list = { "themes", "terms", "fzf", "luasnip", "live_grep_args" },
}

M.trouble = {
  focus = true,
  modes = {
    diagnostics_cascade = {
      mode = "diagnostics", -- inherit from diagnostics mode
      filter = function(items)
        local severity = vim.diagnostic.severity.HINT
        for _, item in ipairs(items) do
          severity = math.min(severity, item.severity)
        end
        return vim.tbl_filter(function(item)
          return item.severity == severity
        end, items)
      end,
    },
    symbols = {
      win = {
        size = 0.4,
      },
    },
    lsp = {
      win = {
        size = 0.3,
      },
    },
  },
}

M.noice = {
  views = {
    cmdline_popup = {
      position = {
        row = 5,
        col = "50%",
      },
    },
  },
  lsp = {
    hover = {
      enabled = false,
    },
    signature = {
      enabled = false,
    },
    override = {
      -- override the default lsp markdown formatter with Noice
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      -- override the lsp markdown formatter with Noice
      ["vim.lsp.util.stylize_markdown"] = true,
      -- override cmp documentation with Noice (needs the other options to work)
      ["cmp.entry.get_documentation"] = true,
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
  },
}

M.which_key = {
  plugins = {
    presets = {
      operators = false, -- adds help for operators like d, y, ...
      motions = false, -- adds help for motions
      text_objects = false, -- help for text objects triggered after entering an operator
      windows = false, -- default bindings on <c-w>
      nav = false, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = false, -- bindings for prefixed with g
    },
  },
  spec = {
    { "<leader>a", group = "Avante", mode = { "n", "v" } },
    { "<leader>c", group = "Context" },
    { "<leader>d", group = "Dap" },
    { "<leader>g", group = "Git" },
    { "<leader>l", group = "Lsp", mode = { "n", "v" } },
    { "<leader>n", group = "NvChad" },
    { "<leader>r", group = "Rename", mode = { "n", "v" } },
    { "<leader>s", group = "Search" },
    { "<leader>t", group = "Trouble" },
    { "<leader>w", group = "Whichkey" },
  },
  icons = {
    rules = false,
  },
  triggers = { { "<leader>", mode = { "n", "v" } } },
}

local HEIGHT_RATIO = 0.7 -- You can change this
local WIDTH_RATIO = 0.7 -- You can change this too
-- git support in nvimtree
M.nvimtree = {
  disable_netrw = true,
  hijack_netrw = true,
  prefer_startup_root = true,
  hijack_cursor = true,
  view = {
    relativenumber = true,
    float = {
      enable = true,
      open_win_config = function()
        local screen_w = vim.opt.columns:get()
        local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
        local window_w = screen_w * WIDTH_RATIO
        local window_h = screen_h * HEIGHT_RATIO
        local window_w_int = math.floor(window_w)
        local window_h_int = math.floor(window_h)
        local center_x = (screen_w - window_w) / 2
        local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
        return {
          border = "single",
          relative = "editor",
          row = center_y,
          col = center_x,
          width = window_w_int,
          height = window_h_int,
        }
      end,
    },
  },

  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    indent_width = 2,
    icons = {
      show = {
        git = true,
      },
    },
  },

  update_focused_file = {
    update_root = true,
  },
}

M.conform = {
  formatters_by_ft = {
    lua = { "stylua" },
    c = { "clang_format" },
    cpp = { "clang_format" },
    go = { "goimports", "gofmt" },
    rust = { "rustfmt" },
    python = { "black" },
    toml = { "taplo" },
    sh = { "shfmt" },
    json = { "jq" },

    -- css = { "prettier" },
    -- html = { "prettier" },
    ["*"] = { "codespell" },
    -- Use the "_" filetype to run formatters on filetypes that don't
    -- have other formatters configured.
    ["_"] = { "trim_whitespace" },
  },
}

return M
