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

function string.starts(String, Start)
 return string.sub(String, 1, string.len(Start)) == Start
end

function Plugin.config(plugin, opts)
  -- disable netrw
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1
  local api = require("nvim-tree.api")
  vim.api.nvim_create_autocmd({ "UIEnter" }, { callback = function(args)
    -- Is buffer real file on the disk
    local real_file = vim.fn.filereadable(args.file) == 1

    -- Is buffer a directory
    local directory = vim.fn.isdirectory(args.file) == 1

    --- Is buffer a [No Name]
    local no_name = args.file == "" and vim.bo[args.buf].biftype == ""

    local cwd = vim.fn.getcwd()
    local data_path = vim.fn.expand(args.file)

    -- Nothing to do for weird input
    if not real_file and not no_name then return end

    local target = cwd
    if directory then
      target = data.file
    elseif not string.starts(data_path, cwd) then
      target = vim.fn.fnamemodify(data_path, ":p:h")
    end
    api.tree.toggle({ path = target, focus = false, find_file = true, })

  end})

  require("nvim-tree").setup(opts)
end

return Plugin
