vim.g.tokyonight_style = "night"
vim.cmd([[
    try
        colorscheme tokyonight
    catch /^Vim\%((\a\+)\)\=:E185/
        colorscheme slate
        set background=dark
    endtry
]])

