-- One theme for light OS mode, one for dark. Neovim follows the terminal's
-- reported background (vim.o.background), which most modern terminals update
-- when the OS appearance toggles. The telescope picker (<leader>st) writes the
-- chosen theme into whichever mode is currently active, and the choice persists.

local M = {}

local state_file = vim.fn.stdpath("state") .. "/theme.json"

M.themes = {
  light = "kanagawa-lotus",
  dark = "slate",
}

local function load()
  local f = io.open(state_file, "r")
  if not f then
    return
  end
  local content = f:read("*a")
  f:close()
  local ok, data = pcall(vim.json.decode, content)
  if ok and type(data) == "table" then
    M.themes.light = data.light or M.themes.light
    M.themes.dark = data.dark or M.themes.dark
  end
end

local function save()
  local f = io.open(state_file, "w")
  if not f then
    return
  end
  f:write(vim.json.encode(M.themes))
  f:close()
end

local applying = false

function M.apply()
  if applying then
    return
  end
  applying = true
  local name = vim.o.background == "light" and M.themes.light or M.themes.dark
  pcall(vim.cmd.colorscheme, name)
  applying = false
end

-- Record a theme into the active mode's slot, persist it, and apply it.
function M.set_current(name)
  if vim.o.background == "light" then
    M.themes.light = name
  else
    M.themes.dark = name
  end
  save()
  M.apply()
end

function M.setup()
  load()
  M.apply()
  vim.api.nvim_create_autocmd("OptionSet", {
    group = vim.api.nvim_create_augroup("appearance_bg", { clear = true }),
    pattern = "background",
    callback = M.apply,
  })
end

return M
