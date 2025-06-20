local overrides = require "configs.overrides"

return {
  -- Disabled plugin
  {
    "nvim-tree/nvim-tree.lua",
    -- enabled = false,
    opts = overrides.nvimtree,
  },

  -- Enabled plugin
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = overrides.conform,
  },

  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "nvimtools/none-ls.nvim",
      dependencies = {
        "gbprod/none-ls-luacheck.nvim",
        "nvimtools/none-ls-extras.nvim",
      },
      config = function()
        require "configs.none-ls"
      end, -- Override to setup mason-lspconfig
    },

    config = function()
      dofile(vim.g.base46_cache .. "lsp")
      require("nvchad.lsp").diagnostic_config()
      require "configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  {
    "lewis6991/gitsigns.nvim",
    opts = function()
      return require "configs.gitsigns"
    end,
  },

  {
    -- Treesitter parse for nvim-gn
    -- Do "TSInstall gn" after plugin download
    "willcassella/nvim-gn",
  },

  {
    "lukas-reineke/virt-column.nvim",
    event = "User FilePost",
    opts = {
      virtcolumn = "100",
      exclude = {
        filetypes = {
          "trouble",
          "fugitive",
          "lazygit",
          "toggleterm",
        },
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      -- "rrethy/nvim-treesitter-textsubjects",
      "nvim-treesitter/nvim-treesitter-textobjects",
      {
        "nvim-treesitter/nvim-treesitter-context",
        cmd = { "TSContextEnable", "TSContextDisable", "TSContextToggle" },
        config = function()
          require("treesitter-context").setup {
            max_lines = 1,
            line_numbers = true,
          }
        end,
      },
    },
    opts = overrides.treesitter,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "benfowler/telescope-luasnip.nvim" },
      { "debugloop/telescope-undo.nvim" },
    },
    opts = overrides.telescope,
    keys = {
      { "<leader>sb", "<cmd> Telescope buffers theme=ivy <cr>", desc = "Search buffer" },
      { "<leader>sf", "<cmd> Telescope find_files theme=ivy <cr>", desc = "Search all files" },
      { "<leader>sF", "<cmd> Telescope git_files theme=ivy <cr>", desc = "Search git files" },
      { "<leader>sg", "<cmd> Telescope live_grep theme=ivy <cr>", desc = "Search by grep" },
      { "<leader>sh", "<cmd> Telescope help_tags theme=ivy <cr>", desc = "Search help tags" },
      { "<leader>sl", "<cmd> Telescope luasnip theme=ivy<cr>", desc = "Search snippets" },
      { "<leader>sw", "<cmd> Telescope grep_string theme=ivy <cr>", desc = "Search current word" },
      { "<leader>so", "<cmd> Telescope oldfiles theme=ivy <cr>", desc = "Search recent files" },
      {
        "<leader>s/",
        "<cmd> Telescope current_buffer_fuzzy_find theme=ivy <cr>",
        desc = "Search current buffer string",
      },
      { "<leader>gc", "<cmd> Telescope git_commits theme=ivy<CR>", desc = "Git commits" },
    },
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "echasnovski/mini.icons",
    },
    opts = overrides.which_key,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "whichkey")
      require("which-key").setup(opts)
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    opts = function()
      return require "configs.cmp"
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      -- If you don't want scope to be highlights, uncomment this
      -- scope = { enabled = false },
    },
  },

  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "User FilePost",
    config = function()
      dofile(vim.g.base46_cache .. "rainbowdelimiters")
    end,
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = overrides.noice,
    dependencies = {
      "MunifTanjim/nui.nvim",
      {
        "rcarriga/nvim-notify",
        config = function()
          dofile(vim.g.base46_cache .. "notify")
          require("notify").setup {
            render = "minimal",
            stages = "fade",
          }
        end,
      },
    },
  },

  {
    "folke/todo-comments.nvim",
    event = "User FilePost",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      dofile(vim.g.base46_cache .. "todo")
      require("todo-comments").setup {
        highlight = {
          keyword = "bg",
          pattern = [[.*<(KEYWORDS)\s*(.*):]],
        },
        search = {
          pattern = [[\b(KEYWORDS)\s*(.*):]],
        },
      }
    end,
  },

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "Trouble" },
    keys = {
      {
        "<leader>td",
        "<cmd>Trouble diagnostics_cascade toggle<cr>",
        desc = "Diagnostics",
      },
      {
        "<leader>tD",
        "<cmd>Trouble diagnostics_cascade toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics",
      },
      {
        "<leader>tl",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>ts",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "LSP Symbols",
      },
      {
        "<leader>tr",
        "<cmd>Trouble lsp toggle<cr>",
        desc = "LSP Definitions / References",
      },
      {
        "<leader>tt",
        "<cmd>Trouble telescope<cr>",
        desc = "Telescope result",
      },
      {
        "<leader>q",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
    opts = overrides.trouble,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "trouble")
      require("trouble").setup(opts)
    end,
  },

  {
    "smoka7/hop.nvim",
    -- cmd = { "HopWordCurrentLine", "HopWord" },
    event = "User FilePost",
    config = function()
      dofile(vim.g.base46_cache .. "hop")
      local hop = require "hop"
      hop.setup { keys = "etovxqpdygfblzhckisuran" }
      -- place this in one of your configuration file(s)
      -- local directions = require("hop.hint").HintDirection
      -- vim.keymap.set("", "f", function()
      --   hop.hint_char1 { direction = directions.AFTER_CURSOR, current_line_only = true }
      -- end, { remap = true })
      -- vim.keymap.set("", "F", function()
      --   hop.hint_char1 { direction = directions.BEFORE_CURSOR, current_line_only = true }
      -- end, { remap = true })
      -- vim.keymap.set("", "t", function()
      --   hop.hint_char1 { direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 }
      -- end, { remap = true })
      -- vim.keymap.set("", "T", function()
      --   hop.hint_char1 { direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 }
      -- end, { remap = true })
    end,
  },

  {
    "mfussenegger/nvim-treehopper",
    dependencies = { "smoka7/hop.nvim" },
    config = function()
      require("tsht").config.hint_keys = { "h", "j", "f", "d", "n", "v", "s", "l", "a" }
    end,
  },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("harpoon"):setup {
        settings = {
          save_on_toggle = true,
        },
      }
    end,
    keys = {
      {
        "<C-e>",
        function()
          require("utils.harpoon").toggle_menu()
        end,
        desc = "Harpoon toggle",
      },
      {
        "<C-a>",
        function()
          require("utils.harpoon").add_file()
        end,
        desc = "Harpoon add files",
      },
    },
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },

  {
    "tpope/vim-fugitive",
    cmd = {
      "G",
      "Git",
      "Gdiffsplit",
      "Gread",
      "Gwrite",
      "Ggrep",
      "GMove",
      "GDelete",
      "GBrowse",
      "GRemove",
      "GRename",
      "Glgrep",
      "Gedit",
    },
    ft = { "fugitive" },
  },

  {
    "lambdalisue/suda.vim",
    cmd = { "SudaRead", "SudaWrite" },
  },

  {
    "kitagry/vs-snippets",
    event = "InsertEnter",
    dependencies = {
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local vs_snippets = vim.fn.stdpath "data" .. "/lazy/vs-snippets/snippets"
      require("luasnip.loaders.from_vscode").lazy_load { paths = vs_snippets }
    end,
  },

  {
    "madskjeldgaard/cheeky-snippets.nvim",
    event = "InsertEnter",
    dependencies = {
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local cheeky = require "cheeky"
      cheeky.setup {
        langs = {
          all = true,
          lua = true,
          cpp = true,
          asm = true,
          cmake = true,
          markdown = true,
          supercollider = true,
        },
      }
    end,
  },

  {
    "kaplanz/retrail.nvim",
    event = "User FilePost",
    opts = {
      hlgroup = "ExtraWhitespace",
      filetype = {
        exclude = {
          "diff",
          "git",
          "gitcommit",
          "unite",
          "qf",
          "help",
          "markdown",
          "fugitive",
          "lazygit",
          "toggleterm",
          "terminal",
          "dropbar_menu",
          "fugitiveblame",
        },
      },
    }, -- calls `setup` using provided `opts`
  },

  {
    "nvim-focus/focus.nvim",
    event = "VeryLazy",
    ---@diagnostic disable-next-line: assign-type-mismatch
    version = false,
    config = function()
      local map = vim.keymap.set
      require("focus").setup {
        ui = {
          hybridnumber = true,
        },
        autoresize = {
          width = 87,
          minwidth = 10,
        },
      }
      map("n", "<C-w>s", "<cmd> FocusSplitDown <cr>", { desc = "Horizontal Split" })
      map("n", "<C-w>v", "<cmd> FocusSplitRight <cr>", { desc = "Vertical Split" })
    end,
  },

  {
    "fei6409/log-highlight.nvim",
    ft = "log",
    config = function()
      require("log-highlight").setup {}
    end,
  },

  {
    "aznhe21/actions-preview.nvim",
    config = function()
      require("actions-preview").setup {
        highlight_command = {
          require("actions-preview.highlight").delta "delta --paging=always",
          -- require("actions-preview.highlight").diff_so_fancy(),
          -- require("actions-preview.highlight").diff_highlight(),
        },
        telescope = {
          sorting_strategy = "ascending",
          layout_strategy = "vertical",
          layout_config = {
            width = 0.6,
            -- height = 1,
            prompt_position = "top",
            preview_cutoff = 20,
            preview_height = function(_, _, max_lines)
              return max_lines - 10
            end,
          },
        },
      }
    end,
  },

  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = {
      "ToggleTerm",
      "TermExec",
    },

    config = function()
      require("toggleterm").setup {
        direction = "float",
        open_mapping = "<C-\\>",
        terminal_mappings = true,
        on_open = function(term)
          vim.cmd "startinsert!"
          vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
        end,
        on_close = function(_) end,
        float_opts = {
          winblend = 5,
        },
      }
      function _G.set_terminal_keymaps()
        local opts = { noremap = true }
        vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
      end

      vim.cmd "autocmd! TermOpen term://* lua set_terminal_keymaps()"
    end,
    keys = { { "<C-\\>", mode = { "n", "t" } } },
  },

  {
    "Bekaboo/dropbar.nvim",
    event = "User FilePost",
    -- optional, but required for fuzzy finder support
    -- dependencies = {
    --   "nvim-telescope/telescope-fzf-native.nvim",
    -- },
    config = function()
      local sep = " ❯ "
      if vim.g.neovide then
        sep = "❯ "
      end
      require("dropbar").setup {
        icons = {
          ui = {
            bar = {
              separator = sep,
            },
          },
        },
      }
    end,
  },

  {
    "RRethy/vim-illuminate",
    event = "User FilePost",
    config = function()
      require("illuminate").configure {
        filetypes_denylist = {
          "dirvish",
          "fugitive",
          "NvimTree",
          "mason",
          "lazy",
          "toggleterm",
          "harpoon",
          "telescope",
          "log",
        },
        modes_allowlist = { "n" },
      }
    end,
  },

  {
    "vladdoster/remember.nvim",
    event = "BufReadPre",
    config = function()
      require("remember").setup {
        ignore_buftype = {
          "help",
          "nofile",
          "quickfix",
          "prompt",
        },
        ignore_filetype = {
          "gitcommit",
          "gitrebase",
          "hgcommit",
          "svn",
          "NvimTree",
          "undotree",
          "diff",
          "toggleterm",
          "dapui_scopes",
          "dapui_breakpoints",
          "dapui_stacks",
          "dapui_watchtes",
          "dapui_console",
          "dap-repl",
          "trouble",
        },
      }
    end,
  },

  {
    "danymat/neogen",
    cmd = { "Neogen" },
    config = true,
    opts = {
      snippet_engine = "luasnip",
    },
    -- Uncomment next line if you want to follow only stable versions
    -- version = "*"
  },

  {
    "LunarVim/bigfile.nvim",
    lazy = false,
    config = function()
      -- default config
      require("bigfile").setup {
        filesize = 2, -- size of the file in MiB, the plugin round file sizes to the closest MiB
        pattern = { "*" }, -- autocmd pattern or function see <### Overriding the detection of big files>
        features = { -- features to disable
          "indent_blankline",
          "illuminate",
          "lsp",
          "treesitter",
          "syntax",
          "matchparen",
          "vimopts",
          "filetype",
        },
      }
    end,
  },

  {
    "Fildo7525/pretty_hover",
    event = "LspAttach",
    opts = {},
  },

  {
    "rmagatti/auto-session",
    lazy = false,
    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      session_lens = {
        load_on_setup = false,
      },
      allowed_dirs = {
        "~/workspace/work/tvsdk",
        "~/workspace/platform/cheatsheet/",
        "~/.config/nvim/lua",
      },
      -- suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
      -- log_level = 'debug',
    },
  },
}
