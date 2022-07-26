local configs = require("nvim-treesitter.configs")

configs.setup({
    ensure_installed = {
        "c",
        "lua",
        "javascript",
        "typescript",
        "php",
        "rust",
        "json",
        "python",
        "javascript",
        "sql",
        "dart",
        "html",
        "css",
        "toml",
    }, -- one of "all" or a list of languages
    ignore_install = { "" }, -- List of parsers to ignore installing
    highlight = {
        enable = true, -- false will disable the whole extension
        disable = { "css" }, -- list of language that will be disabled
    },
    autopairs = { enable = true },
    autotag = { enable = true },
    indent = { enable = true, disable = { "python", "css" } },
})
