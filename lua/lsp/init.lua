-- Native LSP using vim.lsp.config / vim.lsp.enable (nvim 0.11+).
--
-- Adding a new server later:
--   1. Install it (mason ensure_installed in lua/plugins/mason.lua, or system PATH).
--   2. vim.lsp.config("<name>", { cmd = {...}, filetypes = {...}, root_markers = {...} })
--   3. vim.lsp.enable("<name>")
-- That is all. No plugin required.
--
-- C# (roslyn) is configured by roslyn.nvim, not here.

vim.diagnostic.config({
  virtual_text = { spacing = 2, prefix = "●" },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = { border = "rounded", source = true },
})

-- Make every server advertise blink.cmp's completion capabilities.
local capabilities = require("blink.cmp").get_lsp_capabilities()
vim.lsp.config("*", { capabilities = capabilities })

vim.lsp.config("rust_analyzer", {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml", "rust-project.json" },
  settings = {
    ["rust-analyzer"] = {
      cargo = { allFeatures = true },
      checkOnSave = true,
      check = { command = "clippy" },
    },
  },
})

vim.lsp.config("hls", {
  cmd = { "haskell-language-server-wrapper", "--lsp" },
  filetypes = { "haskell", "lhaskell" },
  root_markers = { "hie.yaml", "stack.yaml", "cabal.project", "*.cabal", "package.yaml" },
})

vim.lsp.config("ty", {
  cmd = { "ty", "server" },
  filetypes = { "python" },
  root_markers = { "ty.toml", "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
})

vim.lsp.enable({ "rust_analyzer", "hls", "ty" })
