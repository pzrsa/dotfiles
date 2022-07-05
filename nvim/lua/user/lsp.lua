local lspinstaller_status_ok, lspinstaller = pcall(require, "nvim-lsp-installer")
if not lspinstaller_status_ok then
  return
end

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

lspinstaller.setup{
  ensure_installed = {"sumneko_lua", "tsserver", "tailwindcss"},
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗"
    }
  }
}

-- 3. Loop through all of the installed servers and set it up via lspconfig
for _, server in ipairs(lspinstaller.get_installed_servers()) do
  lspconfig[server.name].setup {}
end

lspconfig.sumneko_lua.setup{
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
    },
  },
}

