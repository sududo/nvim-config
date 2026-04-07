return {
  {
    'nvim-tree/nvim-web-devicons',
    opts = {}, 
  },
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function() require('nvim-tree').setup {
      view = {
        width = 30,
      },
      renderer = {
        group_empty = true,
      },
    } end
  },
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function() require('nvim-treesitter').setup {
      install_dir = vim.fn.stdpath('data') .. '/site',
      auto_install = true,
      ensure_installed = { 'html', 'css', 'javascript', 'typescript', 'cpp', 'rust'},
      highlight = { enable = true },
      incremental_selection = { enable = true},
    } end
  },
  {
    "jiaoshijie/undotree",
    opts = {
      -- your options
    },
    keys = {
      { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" },
    },
  },
}
