require("oil").setup({
  default_file_explorer = true,
  view_options = { show_hidden = true },
  keymaps = {
    ["<C-h>"] = false,
    ["<C-l>"] = false,
  },
})

vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>e", "<cmd>Oil .<cr>", { desc = "Open oil in cwd" })
