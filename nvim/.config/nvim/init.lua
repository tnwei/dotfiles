-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Here's my own config I suppose?
-- ref: https://github.com/neovim/neovim/issues/13474#issuecomment-739874877
vim.wo.wrap = true

-- Disable mouse
vim.opt.mouse = ""

-- No concealing anything
vim.opt.conceallevel = 0

-- Get up and down to mean visual up and down
-- In both normal and insert mode
vim.keymap.set("n", "<down>", "gj")
vim.keymap.set("n", "<up>", "gk")
vim.keymap.set("i", "<down>", "<C-o>gj")
vim.keymap.set("i", "<up>", "<C-o>gk")
