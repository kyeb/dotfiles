-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Options
vim.g.mapleader = ","
vim.opt.termguicolors = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamed"

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function() vim.highlight.on_yank({ timeout = 500 }) end,
})

-- Plugins
require("lazy").setup({
  -- Colorscheme
  { "bluz71/vim-nightfly-guicolors", priority = 1000,
    config = function() vim.cmd.colorscheme("nightfly") end },

  -- Treesitter
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({
        auto_install = true,
      })
      vim.treesitter.language.register("bash", "zsh")
    end },

  -- LSP
  { "neovim/nvim-lspconfig" },

  -- Completion
  { "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = { expand = function(args) vim.snippet.expand(args.body) end },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = { { name = "nvim_lsp" } },
      })
    end },

  -- Formatting
  { "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        format_on_save = { timeout_ms = 500, lsp_fallback = true },
        formatters_by_ft = {},
      })
    end },
})

-- Keymaps
local map = function(key, cmd) vim.keymap.set("n", key, cmd) end
map("<Leader>r", ":source $MYVIMRC<CR>")
map("<Leader>h", ":set hlsearch!<CR>")
map("<Leader>cp", ':let @+ = expand("%")<CR>')
vim.keymap.set("t", "<C-a>", "<C-\\><C-n>")
