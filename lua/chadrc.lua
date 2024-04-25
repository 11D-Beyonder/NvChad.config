-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
  lsp = {
    signature = false
  },
  theme = "everforest_light",
  theme_toggle = { "everforest_light", "everforest" }
}

return M

