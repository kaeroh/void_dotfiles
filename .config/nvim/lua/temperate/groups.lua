local M = {}

local colors = require("temperate.palette")

M.setup = function()
  return {

    -- Standard
    Comment = { fg = colors.comment, italic = true },

    --Treesitter
    ["@string"] = { fg = colors.string }

  }
end

return M
