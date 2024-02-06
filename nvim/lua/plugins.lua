-- This file can be loaded by calling `lua require('plugins')` from your init.vim

vim.keymap.set("n", "<C-k><C-p>",
  "<cmd>lua require('fzf-lua').files()<CR>", { silent = true })
vim.keymap.set("n", "<C-k><C-h>",
  "<cmd>lua require('fzf-lua').grep()<CR>", { silent = true })
vim.keymap.set("n", "<C-k><C-g>",
  "<cmd>lua require('fzf-lua').live_grep()<CR>", { silent = true })

return require('lazy').setup({

  -- Simple plugins can be specified as strings
  'rstacruz/vim-closer',

  { "Mofiqul/dracula.nvim", as = 'dracula' },

  "vim-airline/vim-airline",
  "vim-airline/vim-airline-themes",

  { "catppuccin/nvim", as = "catppuccin" },

  "bogado/file-line",
  -- {"neoclide/coc.nvim", branch = "release"},

  { 'neovim/nvim-lspconfig' },

  -- {'glepnir/nerdicons.nvim', cmd = 'NerdIcons', config = function() require('nerdicons').setup({}) end},

  { "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons"}
  },

  { "junegunn/fzf", build = "./install --bin" },

  { "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons"}
  },
})
