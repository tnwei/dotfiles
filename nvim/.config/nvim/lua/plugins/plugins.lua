return {
  -- Is this how to use mason.nvim?
  {
    "sindrets/diffview.nvim",
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        -- "pyright",
        "ruff",
        "ruff-lsp",
        "biome",
        "svelte-language-server",
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
    opts = function(_, opts)
      -- Fix inlay hints based on Neovim version
      if vim.fn.has("nvim-0.10") == 1 then
        -- Neovim 0.10+ uses the new inlay hints API
        opts.inlay_hints = { enabled = false }
      else
        -- Neovim 0.9 and below needs the old way
        opts.inlay_hints = false
      end

      opts.servers = vim.tbl_deep_extend("force", opts.server or {}, {
        pyright = {
          -- this line if uncommented prevents pyright from being installed
          -- mason = false,
          autoImportCompletion = true,
        },
        ruff_lsp = {
          enabled = true,
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
      })
      opts.setup = vim.tbl_deep_extend("force", opts.setup or {}, {
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
      })
      return opts
    end,
  },
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
