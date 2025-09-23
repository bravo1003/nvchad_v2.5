-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic, etc
-- base30 variable names can also be used as colors

local M = {}

---@type Base46HLGroupsList
M.override = {
  Comment =                     { fg = "light_grey", italic = true },
  ["@comment"] =                { fg = "light_grey", italic = true },
  CursorLine =                  { bg = "one_bg" },
  CursorLineNr =                { fg = "blue" },
  LineNr =                      { fg = "light_grey" },
  LspReferenceRead =            { link = "CursorLine" },
  LspReferenceWrite =           { link = "CursorLine" },
  LspReferenceText =            { link = "CursorLine" },
  LspSignatureActiveParameter = { link = "Visual" },
  PmenuSel =                    { bg = "lavender" },
  Visual =                      { bg = "grey_fg" },
  DiffAdd =                     { fg = "none", bg = "#404f4a" },
  DiffDelete  =                 { fg = "none", bg = "#53394c" },
  DiffChange  =                 { fg = "none", bg = "#544f4e" },
  DiffText =                    { fg = "none", bg = "#6d684e" },
}

---@type HLTable
M.add = {
  TreesitterContext =           { link = "Normal" },
  TSNodeKey =                   { link = "HopNextKey" },
  TelescopeSelectionCaret =     { fg = "green", bg = "one_bg" },
  ExtraWhitespace =             { bg = "red" },
  NormalMode =                  { fg = "blue"},
  CommandMode =                 { fg = "green" },
  InsertMode =                  { fg = "purple" },
  VisualMode =                  { fg = "cyan" },
  ReplaceMode =                 { fg = "orange" },
  SelectMode =                  { fg = "teal" },
  TerminalMode =                { fg = "green" },
  TerminalNormalMode =          { fg = "yellow" },
  IlluminatedWordText =         { link = "CursorLine" },
  IlluminatedWordRead =         { link = "CursorLine" },
  IlluminatedWordWrite =        { link = "CursorLine" },
  SnacksPickerListCursorLine =  { link = "CursorLine" },
  SnacksPickerTitle =           { bg = "blue", fg = "black" },
  SnacksPickerBorder =          { fg = "blue", bg = "darker_black" },
  SnacksPickerGitStatusUntracked = { fg = "baby_pink" },
}

return M
