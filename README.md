# NVChad Config

![Config Rule](https://nvchad.com/illustrations/config_nutshell.webp)

## Snippets

Configuration rules of snippets can be found in [NvChad Doc](https://nvchad.com/docs/config/snippets).

All snippets are stored in `~/.config/nvim/lua/custom/snippets/`.

### VSCode Snippets

All snippets written by `jsonc` are stored in `~/.config/nvim/lua/custom/snippets/vscode_snippets/`,
and the path should be put in `~/.config/nvim/lua/custom/init.lua`.

```lua
vim.g.vscode_snippets_path = "~/.config/nvim/lua/custom/snippets/vscode_snippets"
```

There must be file named `package.json` to manage snippets for different programming language types.

```json
{
	"name": "vscode_snippets",
	"contributes": {
		"snippets": [
			{
				"language": [
					"all"
				],
				"path": "./all.json"
			},
			{
				"language": [
					"lua"
				],
				"path": "./lua.json"
			},
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
For example, the snippets for `C++` is written as follows:

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

that is, you can type `hello` if you want a line of code `std::cout<<\"Hello, world!\"<<std::endl;`
to print "Hello, world!".
