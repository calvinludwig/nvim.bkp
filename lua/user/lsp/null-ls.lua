local null_ls = require("null-ls")
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
    debug = false,
    sources = {
        null_ls.builtins.code_actions.eslint_d,
        diagnostics.php,
        diagnostics.eslint_d,
        formatting.eslint_d,
        formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
        formatting.black.with({ extra_args = { "--fast" } }),
        formatting.stylua,
        formatting.rustfmt,
        diagnostics.flake8,
    },
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            -- vim.api.nvim_create_autocmd("BufWritePre", {
            -- 	group = augroup,
            -- 	buffer = bufnr,
            -- 	callback = function()
            -- 		-- vim.lsp.buf.format({ bufnr = bufnr }) this in 0.8
            -- 		vim.lsp.buf.formatting_sync()
            -- 	end,
            -- })
        end
    end,
})
