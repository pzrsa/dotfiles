return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              workspace = { library = vim.api.nvim_get_runtime_file("", true) },
              runtime = { version = "LuaJIT" },
            },
          },
        },
        -- LazyVim uses vtsls by default (modern replacement for tsserver)
        vtsls = {
          settings = {
            complete_function_calls = true,
            typescript = {
              preferences = {
                importModuleSpecifier = "relative",
              },
            },
          },
        },
        tailwindcss = {},
        prismals = {},
        astro = {},
        basedpyright = {},
        jsonls = {},
        eslint = {},
      },
    },
  },
}
