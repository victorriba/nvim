local present, nvimtree = pcall(require, "nvim-tree")
local gheight = vim.api.nvim_list_uis()[1].height
local gwidth = vim.api.nvim_list_uis()[1].width
local width = 50
local height = 30

if not present then
  return
end

require("base46").load_highlight "nvimtree"

local options = {
  filters = {
    dotfiles = false,
    exclude = { vim.fn.stdpath "config" .. "/lua/custom" },
  },
  disable_netrw = true,
  hijack_netrw = true,
  open_on_setup = false,
  ignore_ft_on_setup = { "alpha" },
  hijack_cursor = true,
  hijack_unnamed_buffer_when_opening = false,
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = false,
  },
  view = {
    adaptive_size = true,
    side = "left",
    width = 40,
    hide_root_folder = true,
    mappings = {
      list = {
        { key = "v", action = "vsplit" },
      },
    },
    float = {
      enable = true,
      quit_on_focus_loss = true,
      open_win_config = {
         relative = "editor",
         border = "rounded",
         width = width,
         height = height,
         row = (gheight - height) * 0.5,
         col = (gwidth - width) * 0.5,
      },
    },
  },
  git = {
    enable = false,
    ignore = true,
  },
  filesystem_watchers = {
    enable = true,
  },
  actions = {
    open_file = {
      resize_window = true,
    },
  },
  renderer = {
    highlight_git = false,
    highlight_opened_files = "none",

    indent_markers = {
      enable = false,
    },

    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = false,
      },

      glyphs = {
        default = "",
        symlink = "",
        folder = {
          default = "",
          empty = "",
          empty_open = "",
          open = "",
          symlink = "",
          symlink_open = "",
          arrow_open = "",
          arrow_closed = "",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
}

-- check for any override
options = require("core.utils").load_override(options, "kyazdani42/nvim-tree.lua")
vim.g.nvimtree_side = options.view.side

nvimtree.setup(options)
