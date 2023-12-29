{ config, pkgs, ... }: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      lua
      lua-language-server
      rnix-lsp
    ];
    extraLuaConfig = ''
      -- remap nvim convenience functions
      local g = vim.g
      local o = vim.opt
      local c = vim.cmd
      local a = vim.api
      local k = vim.keymap.set
      local ons = { noremap = true, silent = true }
      
      -- leader key configuration
      g.mapleader = " "
      g.maplocalleader = ' '
      k("", "<Space>", "<Nop>", ons)

      -- tab & indentation
      o.tabstop = 2
      o.shiftwidth = 2
      o.softtabstop = 2
      o.expandtab = true
      -- o.smarttab = true
      o.smartindent = true
      -- o.autoindent = true
      -- o.cpoptions = 'I'
      -- o.breakindent = true

      -- disable swap files
      o.swapfile = false
      o.backup = false

      -- undo settings
      o.undofile = true
      o.undodir = os.getenv("HOME") .. "/.vim/undodir"

      -- wrap lines
      o.wrap = false
      o.linebreak = true

      -- file format and encodinf UTF-8
      o.fileencoding = "utf-8"
      o.fileformats=unix

      -- auto reload files changed outside of vim
      o.autoread = true

      -- display relative line number
      o.number = true
      o.relativenumber = true

      -- search settings
      o.smartcase = true
      o.ignorecase = true
      o.hlsearch = false
      o.incsearch = true

      -- appearance
      o.termguicolors = true
      o.mouse = "a"
      o.signcolumn = "yes"
      o.guicursor = ""
      o.scrolloff = 8
      o.sidescrolloff = 8
      -- vim.opt.colorcolumn = "80"
      o.updatetime = 300
      o.timeoutlen = 300
      o.cursorline = true

      -- split windows below and to the right
      o.splitbelow = true
      o.splitright = true

      -- key mappings
      k("n", "<leader>pv", vim.cmd.Ex)
      k("n", "<leader>q", vim.cmd.quit)

      -- move lines
      k("v", "J", ":m '>+1<CR>gv=gv")
      k("v", "K", ":m '<-2<CR>gv=gv")

      -- join lines without inserting a space
      vim.keymap.set("n", "J", "mzJ`z")

      -- paste over the current selection
      k("x", "<leader>p", [["_dP]])

      -- copy/cut to the system clipboard
      k({"n", "v"}, "<leader>y", [["+y]])
      k({"n", "v"}, "<leader>d", [["_d]])
      k("n", "<leader>Y", [["+Y]])
      o.clipboard = 'unnamedplus'

      -- press jk/kj fast to exit insert mode 
      k("i", "jk", "<ESC>", ons)
      k("i", "kj", "<ESC>", ons)

      -- move windows with Ctrl + hjkl keys
      k("n", "<C-h>", "<C-w>h", ons)
      k("n", "<C-j>", "<C-w>j", ons)
      k("n", "<C-k>", "<C-w>k", ons)
      k("n", "<C-l>", "<C-w>l", ons)
      
      -- split windows horizontally and vertically
      k("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
      k("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
      
      k("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
      k("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })
       
      -- navigate buffers
      k("n", "<S-l>", ":bnext<CR>", ons)
      k("n", "<S-h>", ":bprevious<CR>", ons)

      -- resize with arrows
      k("n", "<C-Up>", ":resize -2<CR>", ons)
      k("n", "<C-Down>", ":resize +2<CR>", ons)
      k("n", "<C-Left>", ":vertical resize -2<CR>", ons)
      k("n", "<C-Right>", ":vertical resize +2<CR>", ons)

      -- scroll up/down half a page
      k("n", "<C-d>", "<C-d>zz")
      k("n", "<C-u>", "<C-u>zz")

      -- center the cursor when searching
      k("n", "n", "nzzzv")
      k("n", "N", "Nzzzv")

      -- disable the Exit mode
      k("n", "Q", "<nop>", ons)

      -- replace the current word with the word under the cursor
      k("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

      -- make the current file executable
      k("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

      -- vim api mappings
      a.nvim_set_keymap('n', "<M-s>", ':so $MYVIMRC<CR>', {noremap = true, silent = true})
      '';
    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-web-devicons;
        type = "lua";
        config = ''
          require'nvim-web-devicons'.setup{}
        '';
      }
      {
        plugin = lualine-nvim;
        type = "lua";
        config = ''
          require('lualine').setup()
        '';
      }
      {  
      	plugin = comment-nvim;
        type = "lua";
        config = ''
          require('Comment').setup()
	        g.skip_ts_context_commentstring_module = true
        '';
      }
      {
      	plugin = undotree;
      	type = "lua";
      	config = ''
          k("n", "<leader>u", vim.cmd.UndotreeToggle)
      	'';
      }
      {
      	plugin = copilot-lua;
      	type = "lua";
      	config = ''
          require("copilot").setup({
            suggestion = {
              auto_trigger = true,
            }
	        })
      	''; 
      }
      {
      	plugin = vim-fugitive;
      	type = "lua";
      	config =''
          k("n", "<leader>gs", vim.cmd.Git)
      	'';
      }	
      {
      	plugin = nvim-tree-lua;
      	type = "lua";
      	config =''
          require("nvim-tree").setup()
          k("n", "<leader>tr", ":NvimTreeToggle<CR>")
          -- g.loaded_netrw = 1
          -- g.loaded_netrwPlugin = 1
      	'';
      }
      {
      	plugin = rose-pine;
      	type = "lua";
      	config = ''
          require('rose-pine').setup({
            disable_background = true
          })
          function ColorMyPencils(color)
      	    color = color or "rose-pine"
      	    c.colorscheme(color)
      	    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      	    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
          end
          ColorMyPencils()
      	'';
      }
      {
      	plugin = telescope-nvim;
      	type = "lua";
      	config = ''
      	  require('telescope').setup()
      	  k("n", "<leader>ff", ":Telescope find_files<CR>")
      	  k("n", "<leader>fg", ":Telescope live_grep<CR>")
      	  k("n", "<leader>fb", ":Telescope buffers<CR>")
      	  k("n", "<leader>fh", ":Telescope help_tags<CR>")
    	  '';
      }
      {
      	plugin = harpoon2;
      	type = "lua";
      	config = ''
      	  local harpoon = require("harpoon")
          harpoon:setup()
      	  k("n", "<leader>ha", function() harpoon:list():append() end)
      	  k("n", "<leader>he", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
      	  k("n", "<leader>hh", function() harpoon:list():select(1) end)
      	  k("n", "<leader>hj", function() harpoon:list():select(2) end)
      	  k("n", "<leader>hk", function() harpoon:list():select(3) end)
      	  k("n", "<leader>hl", function() harpoon:list():select(4) end)
      	  k("n", "<leader>hp", function() harpoon:list():prev() end)
      	  k("n", "<leader>hn", function() harpoon:list():next() end)
    	  '';
      }
      {
       	plugin = nvim-treesitter;
      	type = "lua";
      	config = ''
    	    require'nvim-treesitter.configs'.setup {
            ensure_installed = {},
      	    auto_install = false,
      	    highlight = { enable = true },
    	      indent = { enable = true },
    	    }
	      '';
      }
      {
      	plugin = toggleterm-nvim;
      	type = "lua";
      	config = ''
      	  require("toggleterm").setup {
      	    size = 20,
      	    open_mapping = [[<c-\>]],
      	    hide_numbers = true,
      	    shade_filetypes = {},
      	    shade_terminals = true,
      	    shading_factor = 1,
      	    start_in_insert = true,
      	    insert_mappings = true,
      	    persist_size = true,
      	    direction = 'float',
      	    close_on_exit = true,
      	    shell = vim.o.shell,
      	    float_opts = {
      	      border = 'single',
      	      winblend = 0,
	            highlights = {
      	        border = "Normal",
	              background = "Normal",
      	      },
	          },
	        }
      	  function _G.set_terminal_keymaps()
  	        local opts = {noremap = true}
    	      vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
 	          vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
  	        vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
      	    vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
	          vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
      	    vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
     	    end
     	    vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
	      '';
      }
      {
        plugin = which-key-nvim;
        type = "lua";
        config = ''
          local wk = require("which-key")
          wk.register(mappings, opts)
        '';
      }

      nvim-ts-context-commentstring # Set the commentstring based on the cursor location in the file
      # gruvbox-nvim # A retro groove color scheme for Neovim
      # copilot-vim # A plugin for generating code with GitHub Copilot
      copilot-cmp
      lsp-colors-nvim # A plugin for highlighting LSP diagnostics
      nvim-lspconfig # A collection of configurations for Neovim's built-in LSP client
      neodev-nvim # A plugin for configuring Neovim
      nvim-cmp # A completion plugin for Neovim
      cmp-buffer # A buffer source for nvim-cmp
      cmp-path # A path source for nvim-cmp
      cmp_luasnip # A LuaSnip source for nvim-cmp
      cmp-nvim-lsp # A LSP source for nvim-cmp
      cmp-nvim-lua # A Lua source for nvim-cmp
      luasnip # A snippet engine for Neovim
      friendly-snippets # A collection of snippets for LuaSnip
      {
        plugin = (nvim-treesitter.withPlugins (p: [
          p.tree-sitter-nix
          p.tree-sitter-vim
          p.tree-sitter-bash
          p.tree-sitter-lua
          p.tree-sitter-python
          p.tree-sitter-c
          p.tree-sitter-rust
          p.tree-sitter-json
          p.tree-sitter-go
          p.tree-sitter-typescript
          p.tree-sitter-javascript
          p.tree-sitter-yaml
          p.tree-sitter-zig
          p.tree-sitter-ocaml
          p.tree-sitter-java
          p.tree-sitter-fish
          p.tree-sitter-terraform
          p.tree-sitter-markdown
          p.tree-sitter-sql
        ]));
      }
    ];
  };
}
