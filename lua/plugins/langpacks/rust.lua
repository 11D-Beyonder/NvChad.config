return {
  {
    "mrcjkb/rustaceanvim",
    version = "^4",
    lazy = false,
  },
  {
    "Saecki/crates.nvim",
    tag = "stable",
    event = { "BufRead Cargo.toml" },
    config = true,
  },
}
