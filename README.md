# NVChad Config

## Rules of Configuration

![Config Rule](https://nvchad.com/illustrations/config_nutshell.webp)

- All user configurations must be written in `~/.config/nvim/lua/custom/`.
- **Don't** modify files in `~/.config/nvim/` except `~/.config/nvim/lua/custom/`.

Next, we will use `custom/` to refer to `~/.config/nvim/lua/custom/`.

## Pre Preparation

We will configure [LSP](https://microsoft.github.io/language-server-protocol/) servers and formatters for JSON and Lua in this part. 

Actually, it is not the time for configuring LSP and formatting. We only need to simply configure LSP and formatting for JSON and Lua so that we can efficiently write the configuration files later on.

We should firstly install [`neovim-lspconfig`](https://github.com/neovim/nvim-lspconfig) for LSP configuration and [`null-ls`](https://github.com/jose-elias-alvarez/null-ls.nvim) for formatting. Specifically, create `custom/plugins.lua`.

```lua
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/null-ls.nvim",
      config = function()
        require "custom.configs.null-ls"
      end,
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
}
```

After that, restart Neovim.

### LSP Configuration for JSON

The LSP server named `lua-language-server` for Lua is already installed during NvChad's initialization. We only need to configure LSP server for JSON.

Command `:MasonInstall json-lsp` will install the [`vscode-json-languageservice`](https://github.com/microsoft/vscode-json-languageservice) using `npm`. After that, create `custom/configs/lspconfig.lua`.

```lua
local lspconfig = require "lspconfig"
lspconfig.jsonls.setup {}
```

### Formatter Configuration for Lua

The LSP server `vscode-json-languageservice` can already be used to formatting. We only need to configure the formatter for Lua. 

Command `:MasonInstall stylua` will install [`StyLua`](https://github.com/JohnnyMorganz/StyLua). After that, create `custom/configs/null-ls.lua`.

```lua
local null_ls = require "null-ls"
local formatting = null_ls.builtins.formatting
null_ls.setup {
  debug = true,
  sources = {
    formatting.stylua,
  },
}
```

## Snippets

Configuration rules of snippets can be found in [Snippets part in NvChad Doc](https://nvchad.com/docs/config/snippets).

All snippets are stored in `custom/snippets/`.

### VSCode Snippets

All snippets written by `jsonc` are stored in `custom/snippets/vscode/`,
and the path should be put in `custom/init.lua`.

```lua
vim.g.vscode_snippets_path = "~/.config/nvim/lua/custom/snippets/vscode/"
```

There must be file named `package.json` to manage snippets for different programming language types.

```json
{
  "name": "VSCode Snippet Manager",
  "contributes": {
    "snippets": [
      {
        "language": [
          "cpp"
        ],
        "path": "./cpp.json"
      }
    ]
  }
}

```

We can write our own snippets in the `jsonc` file whose path is metioned in `package.json`.
For example, the snippets for C++ is written as follows:

```json
{
  "Hello World!":
  {
    "prefix":"hello",
    "body":[
      "std::cout<<\"Hello, world!\"<<std::endl;"
    ]
  }
}
```

that is, you can type `hello` if you want a line of code `std::cout<<"Hello, world!"<<std::endl;`
to print "Hello, world!".
