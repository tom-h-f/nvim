-- All colorscheme configuration lives here. Setups only tune defaults;
-- a theme is applied by config.appearance based on OS light/dark mode.
-- Browse + set the current mode's theme with <leader>st.

require("catppuccin").setup({
  flavour = "mocha",
  integrations = {
    blink_cmp = true,
    gitsigns = true,
    telescope = true,
    mason = true,
    treesitter = true,
    which_key = true,
    indent_blankline = { enabled = true },
    native_lsp = { enabled = true },
  },
})

require("tokyonight").setup({ style = "night" })
require("gruvbox").setup({ contrast = "hard" })
require("kanagawa").setup({ background = { light = "lotus", dark = "dragon" } })
require("nightfox").setup({})
require("rose-pine").setup({ dark_variant = "main" })

require("config.appearance").setup()
