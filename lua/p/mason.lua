local servers = {
    "jsonls",
    "sumneko_lua",
    "tailwindcss",
    "cssls",
    "cssmodules_ls",
    "emmet_ls",
    "html",
    "jsonls",
    "solidity_ls",
    "tsserver",
    "pyright",
    "yamlls",
    "bashls",
    "clangd",
    "rust_analyzer",
    "taplo",
}

local settings = {
    ui = {
        border = "rounded",
        icons = {
            package_installed = "✔️",
            package_pending = "➜",
            package_uninstalled = "✗",
        },
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
}

local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")

mason.setup(settings)
mason_lspconfig.setup({
    ensure_installed = servers,
    automatic_installation = true
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

    lspconfig[server].setup(opts)
end
