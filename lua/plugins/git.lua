require("gitsigns").setup({
  on_attach = function(buf)
    local gs = require("gitsigns")
    local function map(mode, keys, fn, desc)
      vim.keymap.set(mode, keys, fn, { buffer = buf, desc = desc })
    end

    map("n", "]c", function() gs.nav_hunk("next") end, "Next git hunk")
    map("n", "[c", function() gs.nav_hunk("prev") end, "Prev git hunk")

    map("n", "<leader>gs", gs.stage_hunk, "Stage hunk")
    map("n", "<leader>gr", gs.reset_hunk, "Reset hunk")
    map("n", "<leader>gp", gs.preview_hunk, "Preview hunk")
    map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame line")
    map("n", "<leader>gd", gs.diffthis, "Diff this")
    map("n", "<leader>gB", gs.toggle_current_line_blame, "Toggle line blame")
  end,
})
