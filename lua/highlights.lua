-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic, etc
-- base30 variable names can also be used as colors

local M = {}

---@type Base46HLGroupsList
M.override = {
  CursorLine =                  { bg = "one_bg" },
  LspSignatureActiveParameter = { link = "Visual" },
  Comment =                     { italic = true },
  ["@comment"] =                { italic = true },
}

---@type HLTable
M.add = {
  TreesitterContext =       { link = "Normal" },
  TSNodeKey =               { link = "HopNextKey" },
  ExtraWhitespace =         { bg = "red" },
  IlluminatedWordText =     { bg = "one_bg" },
  IlluminatedWordRead =     { bg = "one_bg" },
  IlluminatedWordWrite =    { bg = "one_bg" },
}

return M
