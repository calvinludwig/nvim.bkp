local packer_function = function ()
    use("wbthomason/packer.nvim")
    use("nvim-lua/popup.nvim")
    use("nvim-lua/plenary.nvim")
    use("lewis6991/impatient.nvim")

    -- Mason
    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")

    -- LSP
    use("neovim/nvim-lspconfig")
    use("jose-elias-alvarez/null-ls.nvim")

    --Tree Sitter
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    use("JoosepAlviste/nvim-ts-context-commentstring")
    use("windwp/nvim-ts-autotag")
    use("RRethy/vim-illuminate")

    -- CMP
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-cmdline")
    use("saadparwaiz1/cmp_luasnip")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-nvim-lua")
    use("hrsh7th/cmp-emoji")

    -- snippets
    use("L3MON4D3/LuaSnip")

    -- telescope
    use("nvim-telescope/telescope.nvim")
    use("nvim-telescope/telescope-project.nvim")

    -- ColorSchemes
    use("folke/tokyonight.nvim")
    use({ "catppuccin/nvim", as = "catppuccin" })
    use({ "luisiacc/gruvbox-baby", branch = "main" })
    use({ "rose-pine/neovim", as = "rose-pine", tag = "v1.*" })

    -- Interface
    use("kyazdani42/nvim-web-devicons")
    use("nvim-lualine/lualine.nvim")
    use("akinsho/bufferline.nvim")
    use("moll/vim-bbye")
    use("kyazdani42/nvim-tree.lua")
    use("lewis6991/gitsigns.nvim")
    use("goolord/alpha-nvim")
    use("akinsho/toggleterm.nvim")

    -- Code
    use("windwp/nvim-autopairs")
    use("numToStr/Comment.nvim")

    -- Rust
    use("simrat39/rust-tools.nvim")
    use("saecki/crates.nvim")

    --Debug
    use("mfussenegger/nvim-dap")

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end


local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})

return packer.startup(packer_function)
