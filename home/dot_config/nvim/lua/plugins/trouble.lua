return {
  "folke/trouble.nvim",
  opts = {
    modes = {
      lsp_references = {
        -- Open references in main editor window (full buffer like Zed)
        win = { type = "main" },
        focus = true,
        params = {
          include_declaration = false,
        },
      },
      lsp_definitions = {
        win = { type = "main" },
        focus = true,
      },
      lsp_implementations = {
        win = { type = "main" },
        focus = true,
      },
    },
  },
}
