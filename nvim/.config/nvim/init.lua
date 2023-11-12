-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Here's my own config I suppose?
-- ref: https://github.com/neovim/neovim/issues/13474#issuecomment-739874877
vim.wo.wrap = true

-- Disable mouse
vim.opt.mouse = ""
