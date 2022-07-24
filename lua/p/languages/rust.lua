local rust_tools = require("rust-tools")
local crates = require("crates")

local extension_path = vim.env.HOME .. "/.vscode-server/extensions/vadimcn.vscode-lldb-1.7.3/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
local rust_tools_opts = {
    server = {
        on_attach = require("p.lsp.handlers").on_attach,
        capabilities = require("p.lsp.handlers").capabilities,
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy",
                },
                lens = {
                    enable = true,
                },
            },
        },
    },
    dap = {
        adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
    },
}

rust_tools.setup(rust_tools_opts)
crates.setup()
