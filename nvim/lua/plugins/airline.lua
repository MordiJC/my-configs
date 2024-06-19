local airline = { "vim-airline/vim-airline" }

airline.lazy = false

vim.g.airline_powerline_fonts  = 1
vim.g.airline_theme = "simple"

local airline_themes = { "vim-airline/vim-airline-themes" }

airline_themes.lazy = false

return { airline, airline_themes }
