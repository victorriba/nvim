local present, nvimtree = pcall(require, "nvim-tree")

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
    float = {
        enable = true,
        -- Center the window
        -- Thanks https://github.com/nvim-tree/nvim-tree.lua/pull/1538
        open_win_config = function()
            local screen_w = vim.opt.columns:get()
            local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
            local _height = screen_h * 0.8
            local _width = screen_w * 0.8
            local width = math.floor(_width)
            local height = math.floor(_height)
            local center_y = ((vim.opt.lines:get() - _height) / 2)
                             - vim.opt.cmdheight:get()
            local center_x = (screen_w - _width) / 2
            return {
                    anchor = 'NW',
                    relative = 'editor',
                    border = 'single',
                    row = center_y,
                    col = center_x,
                    width = width,
                    height = height,
                }
            end,
    },
    width = function()
      return math.floor(vim.opt.columns:get() * 0.7)
    end,
    height = function()
      return math.floor((vim.opt.lines:get() - vim.opt.cmdheight:get()) * 0.5)
    end,
    adaptive_size = true,        
    mappings = {
        list = {
            { key = "v", action = "vsplit" },
            { key = "d", action = "trash" },
            { key = "D", action = "remove" },
        }
    },
  },
  git = {
    enable = true,
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
        git = true,
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
-- vim.g.nvimtree_side = options.view.side

nvimtree.setup(options)
