require("lualine").setup({
  options = {
    theme = "auto",
    globalstatus = true,
    section_separators = "",
    component_separators = "",
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { "filename" },
    lualine_x = { { "overseer" }, "encoding", "fileformat", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
})

require("ibl").setup({
  scope = { enabled = true },
})

local wk = require("which-key")
wk.setup({})
wk.add({
  -- groups
  { "<leader>s", group = "search" },
  { "<leader>g", group = "git" },
  { "<leader>c", group = "code" },
  { "<leader>t", group = "toggle" },
  { "<leader>r", group = "run/rename" },

  -- standalone keys
  { "<leader>a", desc = "Harpoon: add file" },
  { "<leader>h", desc = "Harpoon: menu" },
  { "<leader>e", desc = "Explorer" },
  { "<leader>w", desc = "Write" },
  { "<leader>q", desc = "Quit" },
  { "<leader>y", desc = "Yank to clipboard", mode = { "n", "v" } },
  { "<leader>Y", desc = "Yank line to clipboard" },
  { "<leader>1", desc = "Harpoon: file 1" },
  { "<leader>2", desc = "Harpoon: file 2" },
  { "<leader>3", desc = "Harpoon: file 3" },
  { "<leader>4", desc = "Harpoon: file 4" },
  { "<leader>5", desc = "Harpoon: file 5" },
})
