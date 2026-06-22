local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd("TextYankPost", {
  group = augroup("highlight_yank", { clear = true }),
  callback = function()
    vim.hl.on_yank({ timeout = 150 })
  end,
})

-- vim.pack has no declarative build hooks, so build native deps on install/update.
autocmd("PackChanged", {
  group = augroup("pack_build", { clear = true }),
  callback = function(args)
    local data = args.data or {}
    if data.kind ~= "install" and data.kind ~= "update" then
      return
    end
    local name = data.spec and data.spec.name or ""
    local path = data.path

    if name == "telescope-fzf-native.nvim" and path then
      vim.notify("Building telescope-fzf-native...", vim.log.levels.INFO)
      vim.system({ "make" }, { cwd = path }, function(out)
        local level = out.code == 0 and vim.log.levels.INFO or vim.log.levels.ERROR
        vim.schedule(function()
          vim.notify("telescope-fzf-native build exit " .. out.code, level)
        end)
      end)
    end

    if name == "nvim-treesitter" then
      vim.schedule(function()
        pcall(vim.cmd, "TSUpdate")
      end)
    end
  end,
})

autocmd("LspAttach", {
  group = augroup("lsp_attach", { clear = true }),
  callback = function(event)
    local buf = event.buf
    local function map(keys, fn, desc, mode)
      vim.keymap.set(mode or "n", keys, fn, { buffer = buf, desc = "LSP: " .. desc })
    end

    map("gd", vim.lsp.buf.definition, "Goto definition")
    map("gD", vim.lsp.buf.declaration, "Goto declaration")
    map("gri", vim.lsp.buf.implementation, "Goto implementation")
    map("grt", vim.lsp.buf.type_definition, "Goto type definition")
    map("grr", vim.lsp.buf.references, "References")
    map("K", vim.lsp.buf.hover, "Hover")
    map("<leader>rn", vim.lsp.buf.rename, "Rename")
    map("<leader>ca", vim.lsp.buf.code_action, "Code action", { "n", "v" })
    map("<leader>cd", vim.diagnostic.open_float, "Line diagnostics")
    map("[d", function() vim.diagnostic.jump({ count = -1 }) end, "Prev diagnostic")
    map("]d", function() vim.diagnostic.jump({ count = 1 }) end, "Next diagnostic")

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method("textDocument/inlayHint") then
      map("<leader>th", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = buf }), { bufnr = buf })
      end, "Toggle inlay hints")
    end
  end,
})
