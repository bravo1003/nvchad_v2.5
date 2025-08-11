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
  CursorLineNr =                { fg = "blue" },
  LspReferenceRead =            { link = "CursorLine" },
  LspReferenceWrite =           { link = "CursorLine" },
  LspReferenceText =            { link = "CursorLine" },
}

---@type HLTable
M.add = {
  TreesitterContext =       { link = "Normal" },
  TSNodeKey =               { link = "HopNextKey" },
  TelescopeSelectionCaret = { fg = "green", bg = "one_bg" },
  ExtraWhitespace =         { bg = "red" },
  NormalMode =              { fg = "blue"},
  CommandMode =             { fg = "green" },
  InsertMode =              { fg = "purple" },
  VisualMode =              { fg = "cyan" },
  ReplaceMode =             { fg = "orange" },
  SelectMode =              { fg = "teal" },
  TerminalMode =            { fg = "green" },
  TerminalNormalMode =      { fg = "yellow" },
  LspInlayHint =            { fg = "light_grey"},
  IlluminatedWordText =     { link = "CursorLine" },
  IlluminatedWordRead =     { link = "CursorLine" },
  IlluminatedWordWrite =    { link = "CursorLine" },
  SnacksPickerTitle =       { bg = "lavender", fg = "black" },
}

return M
