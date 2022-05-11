local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "css", "javascript", "json", "tsx", "typescript", "lua", "vim" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = true,
  autopairs = {
    enable = true,
  },
  indent = {
    enable = true
  },
  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
