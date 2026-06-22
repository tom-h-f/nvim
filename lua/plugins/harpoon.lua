local harpoon = require("harpoon")
harpoon:setup()

local map = vim.keymap.set

map("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon add file" })
map("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon menu" })

for i = 1, 5 do
  map("n", "<leader>" .. i, function() harpoon:list():select(i) end, { desc = "Harpoon to file " .. i })
end

map("n", "<C-p>", function() harpoon:list():prev() end, { desc = "Harpoon prev" })
map("n", "<C-n>", function() harpoon:list():next() end, { desc = "Harpoon next" })
