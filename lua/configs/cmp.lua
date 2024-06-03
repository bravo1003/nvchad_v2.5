local cmp = require "cmp"

dofile(vim.g.base46_cache .. "cmp")

local cmp_ui = require("nvconfig").ui.cmp
local cmp_style = cmp_ui.style
local format_color = require "nvchad.cmp.format"

local atom_styled = cmp_style == "atom" or cmp_style == "atom_colored"
local fields = (atom_styled or cmp_ui.icons_left) and { "kind", "abbr", "menu" } or { "abbr", "kind", "menu" }

local formatting_style = {
  format = function(entry, item)
    local icons = require "nvchad.icons.lspkind"
    local icon = icons[item.kind] or ""
    local kind = item.kind or ""

    if atom_styled then
      item.menu = kind
      item.menu_hl_group = "LineNr"
      item.kind = " " .. icon .. " "
    elseif cmp_ui.icons_left then
      item.menu = kind
      item.menu_hl_group = "CmpItemKind" .. kind
      item.kind = icon
    else
      item.kind = " " .. icon .. " " .. kind
      item.menu_hl_group = "comment"
    end

    if kind == "Color" and cmp_ui.format_colors.lsp then
      format_color.lsp(entry, item, (not (atom_styled or cmp_ui.icons_left) and kind) or "")
    end

    if #item.abbr > cmp_ui.abbr_maxwidth then
      item.abbr = string.sub(item.abbr, 1, cmp_ui.abbr_maxwidth) .. "…"
    end

    return item
  end,
  fields = fields,
}

local options = {
  completion = {
    keyword_length = 2,
    -- completeopt = "menu,menuone",
    completeopt = "menu,menuone,noselect",
  },
  preselect = cmp.PreselectMode.None,
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },

  formatting = formatting_style,

  window = {
    completion = {
      scrollbar = false,
      side_padding = atom_styled and 0 or 1,
      winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None,FloatBorder:CmpBorder",
      border = atom_styled and "none" or "single",
    },

    documentation = {
      border = "single",
      winhighlight = "Normal:CmpDoc,FloatBorder:CmpDocBorder",
    },
  },

  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<UP>"] = cmp.mapping.select_prev_item(),
    ["<DOWN>"] = cmp.mapping.select_next_item(),

    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = false,
    },

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif require("luasnip").expand_or_jumpable() then
        require("luasnip").expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif require("luasnip").jumpable(-1) then
        require("luasnip").jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = {
    { name = "nvim_lsp", priority = 60 },
    { name = "nvim_lua", priority = 50 },
    { name = "luasnip", priority = 40 },
    { name = "cmp_tabnine", priority = 30 },
    { name = "buffer", priority = 20 },
    { name = "path", priority = 10 },
    { name = "render-markdown", priority = 5 },
  },
}

return options
