-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic, etc
-- base30 variable names can also be used as colors

local M = {}

---@type Base46HLGroupsList
M.override = {
  -- Normal =                      { bg = "#1E1E2E" },
  CursorLine =                  { bg = "one_bg" },
  Visual =                      { bg = "grey_fg" },
  PmenuSel =                    { bg = "lavender" },
  FloatBorder =                 { fg = "lavender" },
  LspSignatureActiveParameter = { link = "Visual" },
  Comment =                     { fg = "light_grey", italic = true },
  ["@comment"] =                { fg = "light_grey", italic = true },
  WinSeparator =                { fg = "light_grey" },
}

---@type HLTable
M.add = {
  TreesitterContext =       { link = "Normal" },
  TSNodeKey =               { link = "HopNextKey" },
  ExtraWhitespace =         { bg = "red" },
  LspInlayHint =            { fg = "light_grey"},
  IlluminatedWordText =     { link = "CursorLine" },
  IlluminatedWordRead =     { link = "CursorLine" },
  IlluminatedWordWrite =    { link = "CursorLine" },
}

return M
