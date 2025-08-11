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
      {
        "nvimtools/none-ls.nvim",
        -- dependencies = {
        --   "nvimtools/none-ls-extras.nvim",
        -- },
        config = function()
          require "configs.none-ls"
        end, -- Override to setup mason-lspconfig
      },
    },

    config = function()
      dofile(vim.g.base46_cache .. "lsp")
      require("nvchad.lsp").diagnostic_config()
      require "configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  {
    "mrcjkb/rustaceanvim",
    version = "^6", -- Recommended
    lazy = false, -- This plugin is already lazy

    init = function()
      vim.g.rustaceanvim = {
        server = {
          on_attach = require("utils.lspkeyremaps").keymaps(),
        },
      }
    end,
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
    "rcarriga/nvim-dap-ui",
    dependencies = {
      {
        "mfussenegger/nvim-dap",
        dependencies = {
          "Joakker/lua-json5",
          build = "./install.sh",
        },
        config = function()
          require "configs.dapconfig"
        end,
      },
      "nvim-neotest/nvim-nio",
      {
        "theHamsta/nvim-dap-virtual-text",
        dependencies = {
          "nvim-treesitter/nvim-treesitter",
        },
        config = function()
          require("nvim-dap-virtual-text").setup()
        end,
      },
    },
    config = function()
      dofile(vim.g.base46_cache .. "dap")
      local dap, dapui = require "dap", require "dapui"
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
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
      { "nvim-telescope/telescope-live-grep-args.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "benfowler/telescope-luasnip.nvim" },
    },
    opts = overrides.telescope,
    keys = {
      { "<leader>sb", "<cmd> Telescope buffers <cr>", desc = "Search buffer" },
      { "<leader>sf", "<cmd> Telescope find_files <cr>", desc = "Search all files" },
      { "<leader>sF", "<cmd> Telescope git_files <cr>", desc = "Search git files" },
      { "<leader>sg", "<cmd> Telescope live_grep <cr>", desc = "Search by grep" },
      {
        "<leader>sG",
        function()
          require("telescope").extensions.live_grep_args.live_grep_args()
        end,
        desc = "Search by grep with args",
      },
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
    dependencies = {
      "Kaiser-Yang/blink-cmp-avante",
      "fang2hou/blink-copilot",
    },
    opts = {
      sources = {
        -- Add 'avante' to the list
        default = { "avante", "copilot" },
        providers = {
          avante = {
            module = "blink-cmp-avante",
            name = "Avante",
          },
          copilot = {
            name = "copilot",
            module = "blink-copilot",
            score_offset = 100,
            async = true,
            opts = {
              max_completions = 1, -- Override global max_completions
            },
          },
        },
      },
      completion = {
        list = {
          selection = { preselect = false, auto_insert = true },
        },
        trigger = {
          show_on_x_blocked_trigger_characters = { "<" },
        },
      },
      cmdline = {
        keymap = { preset = "inherit" },
        completion = {
          menu = { auto_show = true },
          list = {
            selection = { preselect = false, auto_insert = true },
          },
        },
      },
    },
  },

  {
    "hrsh7th/nvim-cmp",
    enabled = false,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    dependencies = "HiPhish/rainbow-delimiters.nvim",
    config = function()
      dofile(vim.g.base46_cache .. "blankline")
      require "configs.indent-blankline"
    end,
  },

  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "User FilePost",
    config = function()
      dofile(vim.g.base46_cache .. "rainbowdelimiters")
      local rainbow_delimiters = require "rainbow-delimiters"

      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
        blacklist = {
          "json",
          "log",
        },
      }
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
    -- This with render markdown makes hover prettier
    "Fildo7525/pretty_hover",
    event = "LspAttach",
    opts = {},
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "Avante" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      file_types = { "markdown", "Avante" },
      completions = {
        blink = {
          enabled = true,
        },
      },
      code = {
        language_border = " ",
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
    "mawkler/modicator.nvim",
    event = "BufReadPre",
    config = function()
      vim.o.termguicolors = true
      vim.o.number = true
      vim.o.relativenumber = true
      vim.o.cursorline = true
      vim.o.cursorlineopt = "both" -- to enable cursorline!
      require("modicator").setup()
    end,
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
    "rmagatti/gx-extended.nvim",
    keys = { "gx" },
    config = function()
      require("gx-extended").setup {
        extensions = {
          { -- match github repos in lazy.nvim plugin specs
            patterns = { "*/plugins/**.lua" },
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
    "mikavilpas/yazi.nvim",
    -- enabled = false,
    cmd = { "Yazi" },
    opts = {
      yazi_floating_window_winblend = 5,
      yazi_floating_window_border = "single",
      highlight_groups = {
        -- See https://github.com/mikavilpas/yazi.nvim/pull/180
        hovered_buffer = nil,
        -- See https://github.com/mikavilpas/yazi.nvim/pull/351
        hovered_buffer_in_same_directory = nil,
      },
    },
  },

  {
    "Bekaboo/dropbar.nvim",
    event = "User FilePost",
    -- optional, but required for fuzzy finder support
    -- dependencies = {
    --   "nvim-telescope/telescope-fzf-native.nvim",
    -- },
    config = function()
      require("dropbar").setup {
        icons = {
          ui = {
            bar = {
              separator = " ❯ ",
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
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
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

  {
    "yetone/avante.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "MeanderingProgrammer/render-markdown.nvim",
      --- The below dependencies are optional,
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      {
        "zbirenbaum/copilot.lua",
        event = "InsertEnter",
        opts = {
          suggestion = { enabled = false },
          panel = { enabled = false },
          filetypes = {
            markdown = true,
            help = true,
          },
        },
      }, -- for providers='copilot'
    },
    build = "make",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    ---@module 'avante'
    ---@type avante.Config
    opts = {
      -- add any opts here
      -- for example
      provider = "copilot",
      auto_suggestions_provider = "copilot",
      windows = {
        ---@type "right" | "left" | "top" | "bottom"
        position = "right", -- the position of the sidebar
        wrap = true, -- similar to vim.o.wrap
        width = 47, -- default % based on available width
        sidebar_header = {
          enabled = true, -- true, false to enable/disable the header
          align = "center", -- left, center, right for title
          rounded = false,
        },
      },
      selector = {
        provider = "telescope",
        -- Options override for custom providers
      },
    },
  },
}
