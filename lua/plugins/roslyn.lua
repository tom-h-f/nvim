-- roslyn.nvim drives the C# Roslyn server (installed via mason). It registers and
-- enables its own LSP config and handles .sln/.csproj detection, so do not also
-- enable "roslyn" manually in lua/lsp/init.lua.
require("roslyn").setup({
  settings = {
    ["csharp|inlay_hints"] = {
      csharp_enable_inlay_hints_for_implicit_object_creation = true,
      csharp_enable_inlay_hints_for_implicit_variable_types = true,
    },
    ["csharp|code_lens"] = {
      dotnet_enable_references_code_lens = true,
    },
  },
})
