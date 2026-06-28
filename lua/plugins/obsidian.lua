require("obsidian").setup({
  workspaces = {
    { name = "vault", path = "~/Vault" },
  },
  legacy_commands = false,
  completion = {
    min_chars = 2,
  },
  ui = { enable = true },
  picker = { name = "telescope.nvim" },
  notes_subdir = "notes",
  new_notes_location = "notes_subdir",
})

vim.keymap.set("n", "<leader>on", "<cmd>Obsidian new<cr>", { desc = "Obsidian new note" })
vim.keymap.set("n", "<leader>oo", "<cmd>Obsidian quick_switch<cr>", { desc = "Obsidian quick switch" })
vim.keymap.set("n", "<leader>os", "<cmd>Obsidian search<cr>", { desc = "Obsidian search" })
vim.keymap.set("n", "<leader>ot", "<cmd>Obsidian today<cr>", { desc = "Obsidian today's daily note" })
vim.keymap.set("n", "<leader>ob", "<cmd>Obsidian backlinks<cr>", { desc = "Obsidian backlinks" })
vim.keymap.set("n", "<leader>ol", "<cmd>Obsidian links<cr>", { desc = "Obsidian links" })
vim.keymap.set("n", "<leader>og", "<cmd>Obsidian follow_link<cr>", { desc = "Obsidian follow link" })
