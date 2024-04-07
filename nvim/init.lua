vim.opt.encoding = "utf-8"

-- Example using a list of specs with the default options
vim.g.mapleader = "\\" -- Make sure to set `mapleader` before lazy so your mappings are correct

vim.g.airline_powerline_fonts  = 1
vim.g.airline_theme = "simple"

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('plugins')
require('nvim-web-devicons').setup()

-- OR setup with some options
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

local function open_nvim_tree()

  -- open the tree
  require("nvim-tree.api").tree.open()
end
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

-- require('coc_config')

local lspconfig = require('lspconfig')
lspconfig.clangd.setup {}
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<C-k><C-f>', function()
      vim.lsp.buf.format({ async = true })
    end, opts)
    vim.keymap.set('v', '<C-k><C-f>', function()
      vim.lsp.buf.format({
        async = true,
        range = {
          ["start"] = vim.api.nvim_buf_get_mark(0, "<"),
          ["end"] = vim.api.nvim_buf_get_mark(0, ">"),
      }
    })
    end, opts)
  end,
})

lspconfig.rust_analyzer.setup({
    on_attach = on_attach,
    settings = {
        ["rust-analyzer"] = {
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            cargo = {
                buildScripts = {
                    enable = true,
                },
            },
            procMacro = {
                enable = true
            },
        }
    }
})

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
