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
vim.keymap.set("n", "<down>", "gj")
vim.keymap.set("n", "<up>", "gk")

-- Configure Pyright
-- Prefer to have this in plugins/
require('lspconfig').pyright.setup({
    settings = {
        pyright = {autoImportCompletion = true,}
    }
})
