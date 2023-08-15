-- References
-- - https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
-- - https://github.com/chaozwn/nvim_video/blob/main/plugins/cmp.lua

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

local cmp = require "cmp"
local luasnip = require "luasnip"
local options = require "plugins.configs.cmp"

options.completion.completeopt = "menu,menuone,noinsert"

options.mapping = {
  ["<C-k>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
  ["<C-j>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
  ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
  ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
  ["<Tab>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      local entry = cmp.get_selected_entry()
      if not entry then
        cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
      else
        if has_words_before() then
          cmp.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
          }
        else
          cmp.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = false,
          }
        end
      end
    elseif luasnip.expand_or_locally_jumpable() then
      luasnip.expand_or_jump()
    else
      fallback()
    end
  end, { "i", "s" }),
  ["<S-Tab>"] = cmp.mapping(function()
    if luasnip.jumpable(-1) then
      luasnip.jump(-1)
    end
  end, { "i", "s" })
}
return options
