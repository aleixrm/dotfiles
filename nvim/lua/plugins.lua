-- Returns a table of plugin specs for lazy.nvim to handle. They will be
-- automatically installed when starting nvim.
--
-- See https://daler.github.io/dotfiles/vim.html#plugins for descriptions and
-- keymappings...or read on.
--
-- In general, plugins are lazy-loaded if possible. Loading can be triggered by
-- commands, filetypes, or keymappings. Many plugins have keymappings, and
-- along with the description these are picked up by which-key.

return {
    { "folke/which-key.nvim", lazy = false, config = true, }, -- pop up a window showing possible keybindings
    { "folke/tokyonight.nvim", lazy = true, opts = { style = "moon" }, }, -- colorscheme
}
