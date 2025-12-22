-- init.lua or any Lua config file that runs after Telescope is loaded
local builtin = require('telescope.builtin')

-- <leader>fd will launch a file search that ignores .gitignore
vim.keymap.set('n', '<leader>fd', function()
  builtin.find_files({
    hidden   = true,   -- show dotfiles (optional)
    no_ignore = true,  -- bypass .gitignore
  })
end, { desc = 'Find Files (no-ignore)' })

return {
  -- "nvim-mini/mini.files",
  -- keys = {
  --   {
  --     "<leader>e",
  --     function()
  --       require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
  --     end,
  --     desc = "Open mini.files (directory of current file)",
  --   },
  --   {
  --     "<leader>E",
  --     function()
  --       require("mini.files").open(vim.uv.cwd(), true)
  --     end,
  --     desc = "Open mini.files (cwd)",
  --   },
  --   {
  --     "<leader>fm",
  --     function()
  --       require("mini.files").open(LazyVim.root(), true)
  --     end,
  --     desc = "Open mini.files (root)",
  --   },
  -- },
  -- opts = {
  --   mappings = {
  --     go_in = "<Right>",
  --     go_out = "<Left>",
  --   },
  --   windows = {
  --     width_nofocus = 20,
  --     width_focus = 50,
  --     width_preview = 100,
  --   },
  --   options = {
  --     use_as_default_explorer = true,
  --   },
  -- },
}
