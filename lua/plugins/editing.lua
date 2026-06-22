require("nvim-autopairs").setup({})

local conform = require("conform")
conform.setup({
  formatters_by_ft = {
    python = { "ruff_format", "ruff_organize_imports" },
    rust = { "rustfmt" },
    haskell = { "fourmolu" },
    lua = { "stylua" },
    json = { "prettierd", "prettier", stop_after_first = true },
    yaml = { "prettierd", "prettier", stop_after_first = true },
  },
  format_on_save = {
    timeout_ms = 1500,
    lsp_format = "fallback",
  },
})

vim.keymap.set({ "n", "v" }, "<leader>cf", function()
  conform.format({ async = true, lsp_format = "fallback" })
end, { desc = "Format buffer" })

local lint = require("lint")
lint.linters_by_ft = {
  python = { "ruff" },
}

vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
  group = vim.api.nvim_create_augroup("nvim_lint", { clear = true }),
  callback = function()
    lint.try_lint()
  end,
})
