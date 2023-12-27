{ config, pkgs, ... }: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      lua-language-server
      rnix-lsp
    ];
    extraLuaConfig = ''
      local g = vim.g
      local o = vim.opt
      local c = vim.cmd
      local a = vim.api
      local k = vim.keymap.set
      local ons = { noremap = true, silent = true }
      
      -- leader key configuration
      g.mapleader = " "  -- Set the global leader key to the space bar.
      g.maplocalleader = ' '  -- Set the local leader key to the space bar

      -- options

      -- display relative line number
      o.number = true
      o.relativenumber = true

      -- search settings
      o.smartcase = true  -- Enable smart case.
      o.ignorecase = true -- Ignore case when searching.`
      o.hlsearch = false -- Disable search highlighting.
      o.incsearch = true -- Enable incremental search.

      -- appearance
      o.termguicolors = true -- Enable 24-bit RGB color support.
      o.signcolumn = "yes"

      -- key mappings
      k("", "<Space>", "<Nop>", ons)
      k("n", "<leader>pv", vim.cmd.Ex)
      k("n", "<leader>q", vim.cmd.quit)

      -- move lines
      k("v", "J", ":m '>+1<CR>gv=gv")
      k("v", "K", ":m '<-2<CR>gv=gv")

      -- Join lines without inserting a space.
      vim.keymap.set("n", "J", "mzJ`z")

      -- Move windows with Ctrl + hjkl keys.
      k("n", "<C-h>", "<C-w>h", ons)
      k("n", "<C-j>", "<C-w>j", ons)
      k("n", "<C-k>", "<C-w>k", ons)
      k("n", "<C-l>", "<C-w>l", ons)

      -- Center the cursor when searching.
      k("n", "n", "nzzzv")
      k("n", "N", "Nzzzv") 

      -- vim api mappings
      a.nvim_set_keymap('n', '<F5>', ':so $MYVIMRC<CR>', {noremap = true, silent = true})
      '';
    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-web-devicons; # Show file icons in Nvim.
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
	  require("toggleterm").setup{
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

      nvim-ts-context-commentstring # Set the commentstring based on the cursor location in the file.
      # gruvbox-nvim # A retro groove color scheme for Neovim.
      # copilot-vim # A plugin for generating code with GitHub Copilot.
      copilot-cmp 
      lsp-colors-nvim # A plugin for highlighting LSP diagnostics.
      nvim-lspconfig # A collection of configurations for Neovim's built-in LSP client.
      neodev-nvim # A plugin for configuring Neovim.
      nvim-cmp # A completion plugin for Neovim.  
      cmp-buffer # A buffer source for nvim-cmp.
      cmp-path # A path source for nvim-cmp.
      cmp_luasnip # A LuaSnip source for nvim-cmp.
      cmp-nvim-lsp # A LSP source for nvim-cmp.
      cmp-nvim-lua # A Lua source for nvim-cmp.
      luasnip # A snippet engine for Neovim.
      friendly-snippets # A collection of snippets for LuaSnip.
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
