local overrides = require "configs.overrides"

return {
  -- Disabled plugin
  {
    "hrsh7th/nvim-cmp",
    enabled = false,
  },

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
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      picker = {
        enabled = true,
        layout = "my_telescope_top",
        layouts = {
          my_telescope_top = {
            layout = {
              box = "horizontal",
              backdrop = false,
              width = 0.9,
              height = 0.9,
              border = "none",
              {
                box = "vertical",
                {
                  win = "input",
                  height = 1,
                  border = "single",
                  title = "{title} {live} {flags}",
                  title_pos = "center",
                },
                { win = "list", title = " Results ", title_pos = "center", border = "single" },
              },
              {
                win = "preview",
                title = "{preview:Preview}",
                width = 0.5,
                border = "single",
                title_pos = "center",
              },
            },
          },
        },
      },
      notifier = { enabled = true },
      words = { enabled = true },
      input = { enabled = true },
    },
  },

  {
    -- Treesitter parse for nvim-gn
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
    },
    opts = overrides.telescope,
    keys = {
      { "<leader>sb", "<cmd> Telescope buffers <cr>", desc = "Search buffer" },
      { "<leader>sf", "<cmd> Telescope find_files <cr>", desc = "Search all files" },
      { "<leader>sF", "<cmd> Telescope git_files <cr>", desc = "Search git files" },
      { "<leader>sg", "<cmd> Telescope live_grep <cr>", desc = "Search by grep" },
      { "<leader>sh", "<cmd> Telescope help_tags <cr>", desc = "Search help tags" },
      { "<leader>sl", "<cmd> Telescope luasnip <cr>", desc = "Search snippets" },
      { "<leader>sw", "<cmd> Telescope grep_string <cr>", desc = "Search current word" },
      { "<leader>so", "<cmd> Telescope oldfiles <cr>", desc = "Search recent files" },
      {
        "<leader>s/",
        "<cmd> Telescope current_buffer_fuzzy_find <cr>",
        desc = "Search current buffer string",
      },
      { "<leader>gc", "<cmd> Telescope git_commits <cr>", desc = "Git commits" },
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

  { import = "nvchad.blink.lazyspec" },

  {
    "Saghen/blink.cmp",
    event = "InsertEnter",
    opts = {
      completion = {
        list = {
          selection = { preselect = false, auto_insert = true },
        },
        trigger = {
          show_on_x_blocked_trigger_characters = { "<" },
        },
      },
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
    event = "User FilePost",
    config = function()
      dofile(vim.g.base46_cache .. "hop")
      local hop = require "hop"
      hop.setup { keys = "etovxqpdygfblzhckisuran" }
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
    -- This with render markdown makes hover prettier
    "Fildo7525/pretty_hover",
    event = "LspAttach",
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "Avante" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    }, -- if you use the mini.nvim suite
    opts = {
      file_types = { "markdown", "Avante" },
      completions = {
        blink = {
          enabled = true,
        },
      },
      code = {
        language_border = "",
      },
      latex = { enabled = false },
    },
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
    "fei6409/log-highlight.nvim",
    ft = "log",
    config = function()
      require("log-highlight").setup {}
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
    config = function()
      require("dropbar").setup {}
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
          "diff",
          "toggleterm",
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
        "~/.config/nvim/lua",
      },
      -- suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
      -- log_level = 'debug',
    },
  },
}
