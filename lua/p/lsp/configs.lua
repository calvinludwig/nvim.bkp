local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
    return
end

local lspconfig = require("lspconfig")

local servers = {
    "jsonls",
    "sumneko_lua",
    "rust_analyzer",
    "tsserver",
    "taplo",
    "html",
    "cssls"
}

lsp_installer.setup({
    ensure_installed = servers,
})

for _, server in pairs(servers) do
    local opts = {
        on_attach = require("p.lsp.handlers").on_attach,
        capabilities = require("p.lsp.handlers").capabilities,
    }
    local has_custom_opts, server_custom_opts = pcall(require, "p.lsp.settings." .. server)
    if has_custom_opts then
        opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
    end

    if server == "rust_analyzer" then
        local extension_path = vim.env.HOME .. '/.vscode-server/extensions/vadimcn.vscode-lldb-1.7.3/'
        local codelldb_path = extension_path .. 'adapter/codelldb'
        local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'
        require("rust-tools").setup({
            server = {
                on_attach = require("p.lsp.handlers").on_attach,
                capabilities = require("p.lsp.handlers").capabilities,
                settings = {
                    ["rust-analyzer"] = {
                        checkOnSave = {
                            command = "clippy"
                        },
                        lens = {
                            enable = true
                        }
                    }
                }
            },
            dap = {
                adapter = require('rust-tools.dap').get_codelldb_adapter(
                    codelldb_path,
                    liblldb_path
                )
            }
        })
        goto continue
    end

    lspconfig[server].setup(opts)
    ::continue::
end
