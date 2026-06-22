require("mason").setup()

-- Installs binaries onto mason's PATH. LSP servers are still configured natively
-- in lua/lsp/init.lua. Toolchains already on the system (rust-analyzer, hls, ty)
-- are intentionally not listed here.
require("mason-tool-installer").setup({
  ensure_installed = {
    "roslyn-language-server", -- C# language server, consumed by roslyn.nvim
    "ruff", -- python lint + format
    "stylua", -- lua format
    "fourmolu", -- haskell format
    "prettierd", -- json/yaml format
  },
  run_on_start = true,
})
