local Plugin = { "nvim-tree/nvim-tree.lua" }

Plugin.lazy = false

Plugin.dependencies = {"nvim-tree/nvim-web-devicons"}

Plugin.opts = {
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
}

function Plugin.config(plugin, opts)
  -- disable netrw
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1
  local api = require("nvim-tree.api")
  vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = api.tree.open })

  require("nvim-tree").setup(opts)
end

return Plugin
