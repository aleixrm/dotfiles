--common options
local opts = {
    noremap = true,   --non-recursive
    silent = true,    -- do not show message
}

-- map leader key
vim.g.maplocalleader = ','
vim.g.mapleader = ','

-----------------
-- Normal mode --
-----------------

-- Hint: see `:h vim.map.set()`
-- Better window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)

-- Resize with arrows
-- delta: 2 lines
vim.keymap.set('n', '<C-Up>', ':resize -2 <CR>', opts)
vim.keymap.set('n', '<C-Down>', ':resize +2 <CR>', opts)
vim.keymap.set('n', '<C-Left>', ':vertical resize -2 <CR>', opts)
vim.keymap.set('n', '<C-Right>', ':vertical resize +2 <CR>', opts)


-----------------
-- Visual Mode --
-----------------
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)





