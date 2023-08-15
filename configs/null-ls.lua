local null_ls = require "null-ls"
local formatting = null_ls.builtins.formatting
null_ls.setup {
  debug = true,
  sources = {
    formatting.stylua,
    formatting.clang_format.with({
      extra_args={"--style={BasedOnStyle: Microsoft, IndentWidth: 4}"}
    }),
  },
}
