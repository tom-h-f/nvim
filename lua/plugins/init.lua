local function gh(path)
  return "https://github.com/" .. path
end

vim.pack.add({
  -- core deps
  { src = gh("nvim-lua/plenary.nvim") },
  { src = gh("nvim-tree/nvim-web-devicons") },

  -- treesitter (master branch: stable configs API)
  { src = gh("nvim-treesitter/nvim-treesitter"), version = "master" },

  -- finder
  { src = gh("nvim-telescope/telescope.nvim") },
  { src = gh("nvim-telescope/telescope-fzf-native.nvim") },

  -- completion (pin to 1.x for prebuilt fuzzy binary)
  { src = gh("saghen/blink.cmp"), version = vim.version.range("1") },

  -- files / navigation
  { src = gh("stevearc/oil.nvim") },
  { src = gh("ThePrimeagen/harpoon"), version = "harpoon2" },

  -- git
  { src = gh("lewis6991/gitsigns.nvim") },

  -- colorschemes (dark, high-contrast, elflord-spirit)
  { src = gh("catppuccin/nvim"), name = "catppuccin" },
  { src = gh("folke/tokyonight.nvim") },
  { src = gh("ellisonleao/gruvbox.nvim") },
  { src = gh("rebelot/kanagawa.nvim") },
  { src = gh("EdenEast/nightfox.nvim") },
  { src = gh("rose-pine/neovim"), name = "rose-pine" },

  -- ui
  { src = gh("nvim-lualine/lualine.nvim") },
  { src = gh("folke/which-key.nvim") },
  { src = gh("lukas-reineke/indent-blankline.nvim") },

  -- editing
  { src = gh("windwp/nvim-autopairs") },
  { src = gh("stevearc/conform.nvim") },
  { src = gh("mfussenegger/nvim-lint") },

  -- notes
  { src = gh("obsidian-nvim/obsidian.nvim") },

  -- tmux
  { src = gh("christoomey/vim-tmux-navigator") },

  -- task runner
  { src = gh("stevearc/overseer.nvim") },

  -- lsp tooling
  { src = gh("mason-org/mason.nvim") },
  { src = gh("WhoIsSethDaniel/mason-tool-installer.nvim") },
  { src = gh("seblyng/roslyn.nvim") },
})

require("plugins.themes")
require("plugins.ui")
require("plugins.treesitter")
require("plugins.telescope")
require("plugins.blink")
require("plugins.oil")
require("plugins.harpoon")
require("plugins.git")
require("plugins.editing")
require("plugins.obsidian")
require("plugins.mason")
require("plugins.roslyn")
require("plugins.overseer")
