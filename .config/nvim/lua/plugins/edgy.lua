return {
  "folke/edgy.nvim",
  event = "VeryLazy",
  opts = {
		options = {
			left = { size = 40 },
			bottom = { size = 10 },
			right = { size = 30 },
			top = { size = 10 },
		},
		animate = { enabled = false },
		wo = {
			winbar = true,
			winfixwidth = false,
			winfixheight = false,
			winhighlight = "WinBar:EdgyWinBar,Normal:EdgyNormal",
			spell = false,
			signcolumn = "no",
		},
    bottom = {
      {
        title = "Diag",
        ft = "neo-tree",
        filter = function(buf)
          return vim.b[buf].neo_tree_source == "diagnostics"
        end,
        open = "Neotree position=bottom diagnostics",
      },
      { ft = "toggleterm", size = { height = 0.4 } },
      { ft = "qf", title = "QuickFix" },
      {
        ft = "help",
        size = { height = 20 },
        -- only show help buffers
        filter = function(buf)
          return vim.bo[buf].buftype == "help"
        end,
      },
      { ft = "spectre_panel", size = { height = 0.4 } },
    },
    left = {
      -- Neo-tree filesystem always takes half the screen height
      {
        title = "Files",
        ft = "neo-tree",
        filter = function(buf)
          return vim.b[buf].neo_tree_source == "filesystem"
        end,
        size = { height = 0.5 },
				pinned = true,
        open = "Neotree position=right filesystem",
      },
      {
        title = "Git",
        ft = "neo-tree",
        filter = function(buf)
          return vim.b[buf].neo_tree_source == "git_status"
        end,
        pinned = true,
        open = "Neotree position=right git_status",
      },
      {
        title = "Buffers",
        ft = "neo-tree",
        filter = function(buf)
          return vim.b[buf].neo_tree_source == "buffers"
        end,
        pinned = true,
        open = "Neotree position=top buffers",
      },
      -- any other neo-tree windows
      "neo-tree",
    },
  },
}
