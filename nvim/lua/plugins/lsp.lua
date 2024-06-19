local Plugin = { "neovim/nvim-lspconfig" }
local user = {}

Plugin.dependencies = {
  { "hrsh7th/cmp-nvim-lsp" },
}

Plugin.cmd = {'LspInfo', 'LspInstall', 'LspUnInstall'}

Plugin.event = {'BufReadPre', 'BufNewFile'}

function Plugin.init()
  local sign = function(opts)
    -- See :help sign_define()
    vim.fn.sign_define(opts.name, {
      texthl = opts.name,
      text = opts.text,
      numhl = ''
    })
  end

  sign({name = 'DiagnosticSignError', text = '✘'})
  sign({name = 'DiagnosticSignWarn', text = '▲'})
  sign({name = 'DiagnosticSignHint', text = '⚑'})
  sign({name = 'DiagnosticSignInfo', text = '»'})

  vim.diagnostic.config({
    virtual_text = true,
    severity_sort = true,
    float = {
      border = 'rounded',
      source = 'always',
    },
  })

  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    {border = 'rounded'}
  )

  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    {border = 'rounded'}
  )
end

function Plugin.config()
  local lspconfig = require('lspconfig')

  lspconfig.clangd.setup({})

  local group = vim.api.nvim_create_augroup('lsp_cmds', {clear = true})

  vim.api.nvim_create_autocmd('LspAttach', {
    group = group,
    desc = 'LSP actions',
    callback = user.on_attach
  })

  -- menuone: popup even when there's only one match
  -- noinsert: Do not insert text until a selection is made
  -- noselect: Do not auto-select, nvim-cmp plugin will handle this for us.
  vim.o.completeopt = "menuone,noinsert,noselect"

  -- Avoid showing extra messages when using completion
  vim.opt.shortmess = vim.opt.shortmess + "c"

  -- Set updatetime for CursorHold
  -- 250ms of no cursor movement to trigger CursorHold
  vim.opt.updatetime = 250

  -- Show diagnostic popup on cursor hover
  local diag_float_grp = vim.api.nvim_create_augroup("DiagnosticFloat", { clear = true })
  vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
     vim.diagnostic.open_float(nil, { focusable = false })
    end,
    group = diag_float_grp,
  })

  local format_sync_grp = vim.api.nvim_create_augroup("Format", {})
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.rs",
    callback = function()
      vim.lsp.buf.format({ timeout_ms = 200 })
    end,
    group = format_sync_grp,
  })
end

function user.on_attach(event)
  -- Enable completion triggered by <c-x><c-o>
  vim.bo[event.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

  local bufmap = function(mode, lhs, rhs)
    local opts = {buffer = event.buf}
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  -- Buffer local mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  bufmap('n', '<C-k><C-f>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>')
  vim.keymap.set('v', '<C-k><C-f>', function()
    vim.lsp.buf.format({
      async = true,
      range = {
        ["start"] = vim.api.nvim_buf_get_mark(0, "<"),
        ["end"] = vim.api.nvim_buf_get_mark(0, ">"),
    }
  })
  end, {buffer = event.buf})
  bufmap("n", "<C-]>", vim.lsp.buf.definition)
  bufmap("n", "gh", vim.lsp.buf.hover)
  bufmap("n", "gi", vim.lsp.buf.implementation)
  bufmap("n", "gS", vim.lsp.buf.signature_help)
  bufmap("n", "1gD", vim.lsp.buf.type_definition)
  bufmap("n", "gr", vim.lsp.buf.references)
  bufmap("n", "g0", vim.lsp.buf.document_symbol)
  bufmap("n", "gW", vim.lsp.buf.workspace_symbol)
  bufmap("n", "gd", vim.lsp.buf.definition)
  bufmap("n", "ga", vim.lsp.buf.code_action)
  bufmap("n", "<C-k><C-r>", vim.lsp.buf.rename)

  -- Goto previous/next diagnostic warning/error
  bufmap("n", "g[", vim.diagnostic.goto_prev)
  bufmap("n", "g]", vim.diagnostic.goto_next)
end

return Plugin

