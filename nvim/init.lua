local cmd  = vim.cmd
local opt  = vim.opt
local g    = vim.g
local exec = vim.api.nvim_exec

-- plugin setup is in lua/plugins.lua
require('plugins')
local telescope = require('telescope.builtin')

----------------
--
-- basic setup
--
----------------
opt.termguicolors = true

opt.expandtab = true                -- spaces instead of tabs
opt.tabstop = 2                     -- number of spaces tabs count as
opt.shiftwidth = 2                  -- number of spaces that <<, >>, or other auto indents use

opt.ignorecase = true               -- ignore case when searching
opt.smartcase = true                -- but not if the search contains capitals

opt.number = true                   -- show line numbers

g.mapleader = ","                   -- leader is ,

opt.mouse = 'a'                     -- enable mouse support
opt.clipboard = 'unnamed'           -- use system clipboard

-- highlight on yank
exec([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=500}
  augroup end
]], false)

-- colors!
vim.cmd [[colorscheme nightfly]]

----------------
--
-- shortcuts
--
----------------
local opts = { noremap=true, silent=true }
local map = function(key, cmd)
  vim.api.nvim_set_keymap('n', key, cmd, opts)
end

-- toggle search highlighting
map('<Leader><Space>', ':set hlsearch!<CR>')
-- copy current path to clipboard
map('<Leader>cp', ':let @" = expand("%")<CR>')
-- easier exit from terminal
vim.cmd('tnoremap <C-a> <C-\\><C-n>')
-- easy save
map('<C-s>', ':w')

----------------
--
-- plugin setup
--
----------------

-- Telescope
map('<leader><leader>', "<cmd>lua require('telescope').extensions.frecency.frecency()<CR>")
map('<leader>f', '<cmd>Telescope find_files<CR>')
map('<leader>g', '<cmd>Telescope live_grep<CR>')
map('<leader>b', '<cmd>Telescope buffers<CR>')
map('<leader>b', '<cmd>Telescope buffers<CR>')

-- git-blame
-- TODO: author formatting as username instead of display name
g.gitblame_enabled = 0
g.gitblame_message_template = '   <author> • <date> • <summary>'
g.gitblame_date_format = '%r'
map('<Leader>gb', '<cmd>GitBlameToggle<CR>')

----------------
--
-- tree-sitter, lsp, & null-ls
--
----------------
local ts = require 'nvim-treesitter.configs'
ts.setup {ensure_installed = 'maintained', highlight = {enable = true}}

local lsp = require('lspconfig')

-- Default suggested on_attach from nvim-lspconfig
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- null-ls config copied from sodiumjoe (https://github.com/sodiumjoe/dotfiles)
local null_ls = require("null-ls")
local null_ls_helpers = require("null-ls.helpers")

-- in lua, `0` evaluates as truthy
local function is_executable(bin)
  return vim.fn.executable(bin) > 0
end

local sources = {
  -- eslint
  null_ls_helpers.conditional(function()
    return is_executable("eslint_d") and null_ls.builtins.diagnostics.eslint_d.with({
      cwd = function(params)
        return require("lspconfig/util").root_pattern(".eslintrc.js")(params.bufname)
      end
    })
    or is_executable("eslint") and null_ls.builtins.diagnostics.eslint.with({
      cwd = function(params)
        return require("lspconfig/util").root_pattern(".eslintrc.js")(params.bufname)
      end
    })
  end),
}

null_ls.config({ sources = sources })

local servers = {'flow', 'null-ls'}

for _, server in ipairs(servers) do
  lsp[server].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

