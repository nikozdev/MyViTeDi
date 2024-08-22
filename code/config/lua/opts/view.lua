--lua/opts/view.lua - visual options

vim.cmd("colorscheme nord")

vim.opt["title"] = true
vim.opt["splitright"] = true

vim.opt["mousehide"] = true

vim.opt["visualbell"] = true

vim.opt["lazyredraw"] = true

--[=[
vim.cmd([[
  augroup remember_folds
    autocmd!
    autocmd BufWinLeave *.py mkview
    autocmd BufWinEnter *.py silent! loadview
    autocmd BufWinLeave *.cpp mkview
    autocmd BufWinEnter *.cpp silent! loadview
    autocmd BufWinLeave *.hpp mkview
    autocmd BufWinEnter *.hpp silent! loadview
    autocmd BufWinLeave *.lua mkview
    autocmd BufWinEnter *.lua silent! loadview
  augroup END
]])
--]=]

--endf
