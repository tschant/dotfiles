require("navigator").setup({
  debug = false, -- log output
  code_action_icon = " ",
  width = 0.75, -- max width ratio (number of cols for the floating window) / (window width)
  height = 0.3, -- max list window height, 0.3 by default
  preview_height = 0.35, -- max height of preview windows
  border = {"╭", "─", "╮", "│", "╯", "─", "╰", "│"}, -- border style, can be one of 'none', 'single', 'double',
                                                     -- 'shadow', or a list of chars which defines the border
  default_mapping = true,  -- set to false if you will remap every key
  keymaps = {
  }, -- a list of key maps
  -- please check mapping.lua for all keymaps
  treesitter_analysis = true, -- treesitter variable context
  code_action_prompt = {enable = true, sign = true, sign_priority = 40, virtual_text = true},
  icons = {
    -- Code action
    code_action_icon = " "
  },
  lsp = {
    format_on_save = false
  }
})
