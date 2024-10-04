local overrides = require "configs.overrides"

return {
  -- Disabled plugin: to disable a plugin, add "enabled = false"
  -- A plugin for resizing window size automatically
  -- WARN: might cause trouble with some other fancy window splitting plugin
  {
    "nvim-focus/focus.nvim",
    enabled = false,
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
          minwidth = 15,
        },
      }
      map("n", "<C-w>s", "<cmd> FocusSplitDown <cr>", { desc = "Horizontal Split" })
      map("n", "<C-w>v", "<cmd> FocusSplitRight <cr>", { desc = "Vertical Split" })
    end,
  },
  -- Enabled plugin
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      -- If you don't want scope to be highlights, uncomment this
      -- scope = { enabled = false },
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

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
    "neovim/nvim-lspconfig",
    dependencies = {
      "nvimtools/none-ls.nvim",
      dependencies = {
        "nvimtools/none-ls-extras.nvim",
      },
      config = function()
        require "configs.none-ls"
      end,
    },

    config = function()
      dofile(vim.g.base46_cache .. "lsp")
      require("nvchad.lsp").diagnostic_config()
      require "configs.lspconfig"
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    opts = function()
      return require "configs.gitsigns"
    end,
  },

  {
    -- Treesitter parse for ninja gn files
    -- Do "TSInstall gn" after plugin download
    "willcassella/nvim-gn",
  },

  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      -- "rrethy/nvim-treesitter-textsubjects",
      "nvim-treesitter/nvim-treesitter-textobjects",
      {
        "nvim-treesitter/nvim-treesitter-context",
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
      { "<leader>sb", "<cmd> Telescope buffers <cr>", desc = "Search buffer" },
      { "<leader>sf", "<cmd> Telescope find_files <cr>", desc = "Search all files" },
      { "<leader>sF", "<cmd> Telescope git_files <cr>", desc = "Search git files" },
      { "<leader>sg", "<cmd> Telescope live_grep <cr>", desc = "Search by grep" },
      { "<leader>sh", "<cmd> Telescope help_tags <cr>", desc = "Search help tags" },
      { "<leader>sl", "<cmd> Telescope luasnip<cr>", desc = "Search snippets" },
      { "<leader>sw", "<cmd> Telescope grep_string <cr>", desc = "Search current word" },
      { "<leader>so", "<cmd> Telescope oldfiles <cr>", desc = "Search recent files" },
      {
        "<leader>s/",
        "<cmd> Telescope current_buffer_fuzzy_find <cr>",
        desc = "Search current buffer string",
      },
      { "<leader>nt", "<cmd> Telescope themes <CR>", "Nvchad themes" },
      { "<leader>gc", "<cmd> Telescope git_commits theme=ivy<CR>", desc = "Git commits" },
      { "<leader>nt", "<cmd> Telescope themes <CR>", desc = "Nvchad themes" },
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
      -- custom copy of nvchad.configs.cmp
      -- adds some menu resizing logic and keymaps
      return require "configs.cmp"
    end,
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
        "<cmd>Trouble lsp toggle focus=false<cr>",
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
    event = "User FilePost",
    config = function()
      dofile(vim.g.base46_cache .. "hop")
      local hop = require "hop"
      hop.setup { keys = "etovxqpdygfblzhckisuran" }
      -- If you would like to use hop with fF/tT, uncomment below

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
    "tzachar/cmp-tabnine",
    build = "./install.sh",
    dependencies = "hrsh7th/nvim-cmp",
    event = "InsertEnter",
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
        },
      },
    }, -- calls `setup` using provided `opts`
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
        -- If you have any of the following external diff, uncomment and choose desired one
        -- highlight_command = {
        --   require("actions-preview.highlight").delta "delta --paging=always",
        --   require("actions-preview.highlight").diff_so_fancy(),
        --   require("actions-preview.highlight").diff_highlight(),
        -- },
        telescope = {
          sorting_strategy = "ascending",
          layout_strategy = "vertical",
          layout_config = {
            width = 0.6,
            -- height = 0.9,
            prompt_position = "top",
            preview_cutoff = 20,
            preview_height = function(_, _, max_lines)
              return max_lines - 15
            end,
          },
        },
      }
    end,
  },

  {
    "rmagatti/gx-extended.nvim",
    keys = { { "gx", "gx", desc = "Go to url" } },
    config = function()
      require("gx-extended").setup {
        extensions = {
          { -- match github repos in lazy.nvim plugin specs
            patterns = { "*/plugins/*.lua" },
            name = "neovim plugins",
            match_to_url = function(line_string)
              local line = string.match(line_string, "[\"|'].*/.*[\"|']")
              local repo = vim.split(line, ":")[1]:gsub("[\"|']", "")
              local url = "https://github.com/" .. repo
              return line and repo and url or nil
            end,
          },
        },
        open_fn = require("lazy.util").open,
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
    keys = { { "<C-\\>", mode = { "n", "t" } } },
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
      }
    end,
  },

  {
    "Bekaboo/dropbar.nvim",
    event = "User FilePost",
    -- optional, but required for fuzzy finder support
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
    },
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
          "trouble",
        },
      }
    end,
  },
}
