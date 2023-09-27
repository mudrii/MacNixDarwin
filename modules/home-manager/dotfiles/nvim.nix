{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      telescope-nvim
      harpoon
      undotree
      vim-fugitive
      nvim-treesitter
      nvim-treesitter-parsers.dockerfile
      nvim-treesitter-parsers.c
      nvim-treesitter-parsers.lua
      nvim-treesitter-parsers.rust
      nvim-treesitter-parsers.fish
      nvim-treesitter-parsers.go
      nvim-treesitter-parsers.json
      nvim-treesitter-parsers.nix
      nvim-treesitter-parsers.markdown
      nvim-treesitter-parsers.python
      nvim-treesitter-parsers.sql
      nvim-treesitter-parsers.terraform
      nvim-treesitter-parsers.javascript
      nvim-treesitter-parsers.typescript
      nvim-treesitter-parsers.yaml
#      nvim-treesitter-parsers.zig

    ];

    extraLuaConfig = ''
      vim.g.mapleader = " "

      -- Telescope configuration      
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fr', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})

      -- Treesitter configuration
      require'nvim-treesitter.configs'.setup {
      	highlight = {
        	enable = true,
	  },
        }

      -- Harpoom configuration
      local mark = require("harpoon.mark")
      local ui = require("harpoon.ui")
      vim.keymap.set("n", "<leader>a", mark.add_file)
      vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

      vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
      vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end)
      vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end)
      vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end)

      -- Undotree configration
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

      -- Fugitive configuration
      vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

      vim.opt.guicursor = ""

      vim.opt.nu = true
      vim.opt.relativenumber = true

      vim.opt.tabstop = 4
      vim.opt.softtabstop = 4
      vim.opt.shiftwidth = 4
      vim.opt.expandtab = true

      vim.opt.smartindent = true

      vim.opt.wrap = false

      vim.opt.swapfile = false
      vim.opt.backup = false
      vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
      vim.opt.undofile = true

      vim.opt.hlsearch = false
      vim.opt.incsearch = true

      vim.opt.termguicolors = true

      vim.opt.scrolloff = 8
      vim.opt.signcolumn = "yes"
      vim.opt.isfname:append("@-@")

      vim.opt.updatetime = 50

      vim.opt.colorcolumn = "80"

      '';
  };
}
