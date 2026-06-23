local overseer = require("overseer")

overseer.setup({
  task_list = {
    direction = "right",
    min_width = { 40, 0.2 },
    max_width = { 60, 0.35 },
    default_detail = 1,
    bindings = {
      ["<C-l>"] = false,
      ["<C-h>"] = false,
      q = "<cmd>close<cr>",
      ["<CR>"] = "RunAction",
      o = "OpenOutput",
      ["<C-r>"] = "Restart",
      ["<C-c>"] = "Interrupt",
    },
  },
  task_win = { border = "rounded" },
  component_aliases = {
    default = {
      "on_exit_set_status",
      "on_complete_notify",
      { "on_complete_dispose", timeout = 30 },
    },
  },
})

overseer.register_template({
  name = "uv run",
  priority = 60,
  params = {},
  condition = {
    callback = function(_)
      local buf_dir = vim.fn.expand("%:p:h")
      local base = buf_dir ~= "" and (buf_dir .. ";") or (vim.fn.getcwd() .. ";")
      return vim.fn.findfile("pyproject.toml", base) ~= ""
    end,
  },
  builder = function(_)
    return {
      name = "uv run",
      cmd = { "uv", "run", vim.fn.expand("%:p") },
      components = { { "on_output_quickfix", open = false }, "default" },
    }
  end,
})

local function smart_run()
  local buf_dir = vim.fn.expand("%:p:h")
  local search_base = buf_dir ~= "" and (buf_dir .. ";") or (vim.fn.getcwd() .. ";")

  local function find(f)
    local found = vim.fn.findfile(f, search_base)
    if found ~= "" then return vim.fn.fnamemodify(found, ":p:h") end
  end

  local project_root, task_def
  project_root = find("pyproject.toml")
  if project_root then
    task_def = { name = "uv run", cmd = { "uv", "run", vim.fn.expand("%:p") }, cwd = project_root }
  else
    project_root = find("Cargo.toml")
    if project_root then
      task_def = { name = "cargo run", cmd = { "cargo", "run" }, cwd = project_root }
    else
      project_root = find("Makefile") or find("makefile")
      if project_root then
        task_def = { name = "make", cmd = { "make" }, cwd = project_root }
      end
    end
  end

  if not task_def then
    vim.notify("overseer: no recognised project file", vim.log.levels.WARN)
    return
  end

  local task = overseer.new_task(task_def)
  task:start()
  overseer.open({ enter = false, direction = "right" })
end

local map = vim.keymap.set
map("n", "<leader>rr", smart_run, { desc = "Run project (smart)" })
map("n", "<leader>rt", "<cmd>OverseerToggle right<cr>", { desc = "Toggle task list" })
map("n", "<leader>rl", function()
  local tasks = overseer.list_tasks({ recent_first = true })
  if vim.tbl_isempty(tasks) then
    vim.notify("overseer: no previous task", vim.log.levels.WARN)
    return
  end
  overseer.run_action(tasks[1], "restart")
end, { desc = "Rerun last task" })
map("n", "<leader>ra", function()
  local tasks = overseer.list_tasks({ recent_first = true })
  if not vim.tbl_isempty(tasks) then overseer.run_action(tasks[1]) end
end, { desc = "Action on last task" })
