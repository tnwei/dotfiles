return {
  -- Is this how to use mason.nvim?
  {
    "sindrets/diffview.nvim",
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "pyright",
        -- "black",
        "ruff",
        "ruff-lsp",
        "biome",
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      -- for language support
      -- @see https://biomejs.dev/internals/language-support/
      formatters_by_ft = {
        -- ["javascript"] = { "biome" },
        -- ["javascriptreact"] = { "biome" },
        ["typescript"] = { "biome" },
        -- ["typescriptreact"] = { "biome" },
        ["json"] = { "biome" },
        ["jsonc"] = { "biome" },
        ["markdown"] = {}, -- Empty table means no formatter!
        ["svelte"] = { "svelte-language-server" },
        -- Biome don't support these yet! Using nvim native func
        -- ["css"] = { "biome" },
        -- ["scss"] = { "biome" },
        -- ["html"] = { "biome" },
        -- ["vue"] = { "biome" },
        -- ["yaml"] = { "biome" },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          -- this line if uncommented prevents pyright from being installed
          -- mason = false,
          autoImportCompletion = true,
        },
        ruff_lsp = {
          enabled = lsp == "ruff_lsp",
          keys = {
            {
              "<leader>co",
              function()
                vim.lsp.buf.code_action({
                  apply = true,
                  context = {
                    only = { "source.organizeImports" },
                    diagnostics = {},
                  },
                })
              end,
              desc = "Organize Imports",
            },
          },
        },
        biome = {},
      },
      setup = {
        ruff_lsp = function()
          require("lazyvim.util").lsp.on_attach(function(client, _)
            if client.name == "ruff_lsp" then
              -- Disable hover in favor of Pyright
              -- Edit: remove Pyright
              -- Edit2: added it back coz dunno how to change lsp settings despite all this
              client.server_capabilities.hoverProvider = false
            end
          end)
        end,
      },
    },
  },
  {"folke/zen-mode.nvim"},
  {
    "linux-cultist/venv-selector.nvim",
    cmd = "VenvSelect",
    opts = function(_, opts)
      if require("lazyvim.util").has("nvim-dap-python") then
        opts.dap_enabled = true
      end
      return vim.tbl_deep_extend("force", opts, {
        name = {
          -- "venv",
          -- ".venv",
          -- "env",
          -- ".env",
        },
        anaconda_base_path = "/home/tnwei/miniforge3",
        anaconda_envs_path = "/home/tnwei/miniforge3/envs",
      })
    end,
    keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv" } },
  },
}
