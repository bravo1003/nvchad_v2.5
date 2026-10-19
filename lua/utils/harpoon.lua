local harpoon = require "harpoon"
local harpoon_extensions = require "harpoon.extensions"
harpoon:extend(harpoon_extensions.builtins.highlight_current_file())

local M = {}

M.toggle_menu = function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end

M.add_file = function()
  harpoon:list():add()
end

return M
