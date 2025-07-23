require("vokin")
require("config.lazy")
require("lspconfig").luau_lsp.setup({})
require("config.diagnostics").setup()
