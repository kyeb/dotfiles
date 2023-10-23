return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  -- formatting
  -- TODO: can null-ls do all of this?
  use 'mhartington/formatter.nvim'

  -- lsp stuff
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use 'neovim/nvim-lspconfig'
  use {
    'jose-elias-alvarez/null-ls.nvim',
    requires = {'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig'}
  }
  use 'jose-elias-alvarez/nvim-lsp-ts-utils'

  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }

  use {
    "nvim-telescope/telescope-frecency.nvim",
    config = function()
      require("telescope").load_extension "frecency"
    end,
  }

  use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
}

  -- git stuff
  use 'mhinz/vim-signify'
  use 'f-person/git-blame.nvim'
  use 'rhysd/conflict-marker.vim'

  -- appearance
  use 'bluz71/vim-nightfly-guicolors'

  -- other utils
  use 'jiangmiao/auto-pairs'
end)
