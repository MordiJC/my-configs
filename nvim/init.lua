vim.opt.encoding = "utf-8"

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

require('plugin-config')

vim.cmd("colorscheme catppuccin")

vim.opt.number = true
vim.opt.colorcolumn = "80,96"
vim.opt.ttyfast = true
vim.opt.mouse = "a"
vim.opt.hidden = true
vim.opt.wrap = false
vim.opt.undofile = true
vim.opt.list = true
vim.opt.listchars = "tab:>-,trail:•"
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.cmd([[
autocmd BufNewFile,BufRead *.h,*.c,file_type_*.inc setlocal filetype=c
autocmd BufNewFile,BufRead Makefile.inc,Makefile set syntax=make filetype=make

autocmd FileType rust setlocal tabstop=4 expandtab shiftwidth=4 smarttab
]])

-- need a map method to handle the different kinds of key maps
local function map(mode, combo, mapping, opts)
  local options = {noremap = true}
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, combo, mapping, options)
end

function ToggleListCharsAndLineNumbers()
	if vim.opt.list then
		vim.opt.list = false
	else
		vim.opt.list = true
	end
end
map('', '<C-k><C-l>', ':call ToggleListCharsAndLineNumbers()<CR>')
