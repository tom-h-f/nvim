require("lualine").setup({
  options = {
    theme = "auto",
    globalstatus = true,
    section_separators = "",
    component_separators = "",
  },
})

require("ibl").setup({
  scope = { enabled = true },
})

local wk = require("which-key")
wk.setup({})
wk.add({
  { "<leader>s", group = "search" },
  { "<leader>g", group = "git" },
  { "<leader>c", group = "code" },
  { "<leader>t", group = "toggle" },
  { "<leader>r", group = "rename/refactor" },
})
