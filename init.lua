require("config.lazy")

vim.keymap.set('n', '<leader>to', require("nvim-tree.api").tree.open, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>tc', require("nvim-tree.api").tree.close, { noremap = true, silent = true })

require('undotree').setup({
    float_diff = true,
    --- @type "left_bottom" | "left_left_bottom"
    layout = "left_bottom", -- {left}_{bottom} {left}_{left_bottom}
    --- @type "left" | "right"
    position = "left",
    window = {
        width = 0.25, -- the `undotree` window width percentage related to the editor
        height = 0.25, -- the `preview`(not floating) window height percentage related to the editor
        border = "rounded", -- float window
    },

    ignore_filetype = {},
    --- @type "compact" | "legacy"
    parser = "compact",

    keymaps = {
        ["move_next"] = "j",
        ["move_prev"] = "k",
        ["move2parent"] = "gj",
        ["move_change_next"] = "J",
        ["move_change_prev"] = "K",
        ["action_enter"] = "<cr>",
        ["enter_diffbuf"] = "p", -- this can switch between preview and undotree window
        ["quit"] = "q",
        ["update_undotree_view"] = "S",
    },
})
vim.keymap.set('n', '<leader>uo', require('undotree').open, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>uc', require('undotree').close, { noremap = true, silent = true })

vim.keymap.set('v', '<leader>rp', '"zy<Esc>:%s/<C-R>z//g<Left><Left>')

vim.api.nvim_create_user_command("Config", "tabe | cd ~/.config/nvim/ | e ~/.config/nvim/init.lua | lua require('nvim-tree.api').tree.open()", {
  bang = true,
  desc = 'Open nvim config'
})

vim.api.nvim_create_user_command('Help', "tabe ~/.config/nvim/.cheatsheet", {
  desc = 'Cheatsheet'
}) 

vim.api.nvim_create_user_command('SaveS', "mksession! sesh.vim", {
  desc = 'Saves session to a sesh.vim file'
}) 

vim.api.nvim_create_user_command('LoadS', "source ./sesh.vim", {
  desc = 'Loads session from a sesh.vim file'
}) 

vim.cmd.colorscheme "catppuccin-nvim"

vim.opt.relativenumber = true
vim.opt.number = true

vim.opt.foldenable = true

vim.api.nvim_create_autocmd("FileType", {
  pattern = { '*' },
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(args.match)
    if lang and vim.list_contains(require('nvim-treesitter').get_installed(), lang) then
      vim.treesitter.start(args.buff)
    
      -- Enable folding
      vim.wo.foldmethod = "expr"
      vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    end
  end,
})   

vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*.*",
  callback = function()
    vim.cmd("silent! loadview")
  end,
})   

vim.o.clipboard = 'unnamedplus'
vim.opt.sessionoptions:append("folds")
vim.g.equalalways = false

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', function() builtin.find_files({hidden = true}) end, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
