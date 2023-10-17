---@type ChadrcConfig 
 local M = {}
 M.ui = {
  theme_toggle = {"ayu_dark", "bearded-arc"},
  theme = "bearded-arc",
}
 M.plugins = "custom.plugins"
 M.mappings = require ("custom.mappings")
 return M
