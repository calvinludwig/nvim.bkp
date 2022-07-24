vim.cmd([[
    colorscheme desert
    set background=dark
]])

local themes = {
    "tokyo",
    "cat",
    "gruv",
    "rose",
}

pcall(require, "user.theme." .. themes[4])
