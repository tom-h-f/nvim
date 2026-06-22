local telescope = require("telescope")

telescope.setup({
  defaults = {
    path_display = { "truncate" },
    sorting_strategy = "ascending",
    layout_config = {
      prompt_position = "top",
    },
  },
  pickers = {
    find_files = { hidden = true },
  },
})

-- Loaded only once the native sorter is built (see PackChanged hook).
pcall(telescope.load_extension, "fzf")

local builtin = require("telescope.builtin")
local map = vim.keymap.set

map("n", "<leader>sf", builtin.find_files, { desc = "Search files" })
map("n", "<leader>sg", builtin.live_grep, { desc = "Search by grep" })
map("n", "<leader>sw", builtin.grep_string, { desc = "Search word under cursor" })
map("n", "<leader>sb", builtin.buffers, { desc = "Search buffers" })
map("n", "<leader>sh", builtin.help_tags, { desc = "Search help" })
map("n", "<leader>sd", builtin.diagnostics, { desc = "Search diagnostics" })
map("n", "<leader>sr", builtin.resume, { desc = "Resume last search" })
map("n", "<leader>sk", builtin.keymaps, { desc = "Search keymaps" })
map("n", "<leader>s.", builtin.oldfiles, { desc = "Search recent files" })
map("n", "<leader>st", function()
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  builtin.colorscheme({
    enable_preview = true,
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        local entry = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        if entry then
          require("config.appearance").set_current(entry.value)
        end
      end)
      return true
    end,
  })
end, { desc = "Set current-mode theme (live preview)" })
