-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic, etc
-- base30 variable names can also be used as colors

local M = {}

---@type Base46HLGroupsList
M.override = {
  CursorLine =                  { bg = "one_bg" },
  Comment =                     { italic = true },
  ["@comment"] =                { italic = true },
  LspSignatureActiveParameter = { link = "Visual" },
  LspReferenceRead =            { link = "CursorLine" },
  LspReferenceWrite =           { link = "CursorLine" },
  LspReferenceText =            { link = "CursorLine" },
}

---@type HLTable
M.add = {
  TreesitterContext =       { link = "Normal" },
  TSNodeKey =               { link = "HopNextKey" },
  ExtraWhitespace =         { bg = "red" },
  IlluminatedWordText =     { link = "CursorLine" },
  IlluminatedWordRead =     { link = "CursorLine" },
  IlluminatedWordWrite =    { link = "CursorLine" },
  RenderMarkdownCode =      { link = "black" },
  SnacksPickerBorder =      { fg = "blue", bg = "darker_black" },
}

return M
