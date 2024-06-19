local fzf = { "junegunn/fzf", build = "./install --bin" }

local fzf_lua = { "ibhagwan/fzf-lua" }
fzf_lua.dependencies = { "nvim-tree/nvim-web-devicons"}

function fzf_lua.opts(_, opts)
 local actions = require "fzf-lua.actions"
 return {
   grep = {
     actions = {
       ["ctrl-r"]   = { actions.toggle_ignore },
     },
   },
 }
end

return { fzf, fzf_lua }
