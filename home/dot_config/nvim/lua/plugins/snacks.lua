return {
  "folke/snacks.nvim",
  opts = {
    -- Disable smooth scrolling
    scroll = { enabled = false },
    -- Disable animations
    animate = { enabled = false },
    -- Enable image viewer (works with Ghostty)
    image = { enabled = true },
    -- Enable explorer (file tree)
    explorer = { enabled = true },
    -- Configure picker (keep it simple - defaults work)
    picker = {
      enabled = true,
    },
  },
  keys = {
    -- Disable ALL LazyVim snacks keybindings (we define our own)
    { "<leader><space>", false },
    { "<leader>,", false },
    { "<leader>.", false },
    { "<leader>/", false },
    { "<leader>:", false },
    { "<leader>fb", false },
    { "<leader>fB", false },
    { "<leader>fc", false },
    { "<leader>fe", false },
    { "<leader>fE", false },
    { "<leader>ff", false },
    { "<leader>fF", false },
    { "<leader>fg", false },
    { "<leader>fn", false },
    { "<leader>fp", false },
    { "<leader>fr", false },
    { "<leader>fR", false },
    { "<leader>e", false },
    { "<leader>E", false },
    { "<c-/>", false },
    { "<c-_>", false },
  },
}
