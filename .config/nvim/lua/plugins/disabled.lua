return {
  { "mason-org/mason.nvim", enabled = false },
  { "mason-org/mason-lspconfig.nvim", enabled = false },
  { "mini.files", enabled = false },
  { "folke/snacks.nvim", 
    opts = {
      notifier = { enabled = true },

      picker = {
        hidden = true,
        ignored = true,
        exclude = { ".git" },
      }
  }},
}
