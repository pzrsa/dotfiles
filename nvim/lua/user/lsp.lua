local lsp_installer = require("nvim-lsp-installer")
local lspconfig = require("lspconfig")
local cmp = require("cmp")
local cmpnvimlsp = require("cmp_nvim_lsp")
local luasnip = require("luasnip")

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end
  },
      mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
      sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
		  { name = "path" },
    })
})

lsp_installer.setup {
  ensure_installed = {"sumneko_lua", "tsserver", "gopls"}
}

local capabilities = cmpnvimlsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())

for _, server in ipairs(lsp_installer.get_installed_servers()) do
  lspconfig[server.name].setup({
    capabilities = capabilities,
  })
end

lspconfig.sumneko_lua.setup {
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
}
