return {
  { "rebelot/kanagawa.nvim", lazy=true },
  { "rose-pine/neovim", name = "rose-pine", lazy=true },
  {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
  },
  {"folke/tokyonight.nvim", lazy=true},
  { "ntk148v/habamax.nvim", lazy=true,dependencies={ "rktjmp/lush.nvim" } },
  -- Set the startup colorscheme here
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "everforest",
    },
  },
}
