{ config, pkgs, ... }: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      nil
      lua
      lua-language-server
      rnix-lsp
      gopls
      pyright
      black
      pylint
      nodePackages.typescript
      nodePackages.typescript-language-server
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

      -- fold settings
      o.foldmethod = "syntax"
      o.foldlevel = 1
      o.foldnestmax = 10
      o.foldenable = false
      o.foldcolumn = "1"

      -- file format and encodinf UTF-8
      o.fileencoding = "utf-8"
      o.fileformats = unix

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
      o.mousehide = true
      o.signcolumn = "yes"
      o.guicursor = ""
      o.scrolloff = 8
      o.sidescrolloff = 8
      -- vim.opt.colorcolumn = "80"
      o.updatetime = 300
      o.timeout = true
      o.timeoutlen = 300
      o.cursorline = true
      o.showmatch = true
      o.backspace = 'indent,eol,start'

      -- split windows below and to the right
      o.splitbelow = true
      o.splitright = true
      
      -- Spell checking
      o.spelllang = "en_us"

      -- key mappings
      -- k("n", "<leader>pv", vim.cmd.Ex)
      k("n", "<leader>q", vim.cmd.quit)
      k("n", "<leader>w", vim.cmd.write)

      -- move lines
      k("v", "J", ":m '>+1<CR>gv=gv", ons)
      k("v", "K", ":m '<-2<CR>gv=gv", ons)

      -- join lines without inserting a space
      vim.keymap.set("n", "J", "mzJ`z", ons)

      -- paste over the current selection
      k("x", "<leader>p", [["_dP]], ons)

      -- copy/cut to the system clipboard
      k({"n", "v"}, "<leader>y", [["+y]], ons)
      k({"n", "v"}, "<leader>d", [["_d]], ons)
      k("n", "<leader>Y", [["+Y]], ons)
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
      dressing-nvim #
      lspkind-nvim #
      nvim-ts-context-commentstring # Set the commentstring based on the cursor location in the file
      plenary-nvim # A utility library for Neovim
      nvim-dap # A plugin for debugging with Neovim
      copilot-cmp # copilot-cmp integration with nvim-cmp
      lsp-colors-nvim # A plugin for highlighting LSP diagnostics
      nvim-lspconfig # A collection of configurations for Neovim's built-in LSP client
      neodev-nvim # A plugin for configuring Neovim
      nvim-cmp # A completion plugin for Neovim
      cmp-buffer # A buffer source for nvim-cmp
      cmp-path # A path source for nvim-cmp
      cmp-cmdline # cmp command line
      cmp_luasnip # A LuaSnip source for nvim-cmp
      cmp-look #
      cmp-nvim-lsp # A LSP source for nvim-cmp
      cmp-nvim-lua # A Lua source for nvim-cmp
      luasnip # A snippet engine for Neovim
      friendly-snippets # A collection of snippets for LuaSnip
      {
        plugin = nvim-web-devicons;
        type = "lua";
        config = ''
          require'nvim-web-devicons'.setup{}
        '';
      }
      # {
      #   plugin = rose-pine;
      #   type = "lua";
      #   config = ''
      #     require('rose-pine').setup({
      #         disable_background = true
      #         })
      #     function ColorMyPencils(color)
      #       color = color or "rose-pine"
      #       c.colorscheme(color)
      #       vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      #       vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      #     end
      #     ColorMyPencils()
      #   '';
      # }
      # {
      #   plugin = catppuccin-nvim;
      #   type = "lua";
      #   config = ''
      #     c.colorscheme "catppuccin-macchiato"  -- colorscheme latte, frappe, macchiato, mocha
      #
      #   '';
      # }
      {
        plugin = tokyonight-nvim;
        type = "lua";
        config = ''
          c.colorscheme "tokyonight-storm"  -- colorscheme storm, night, day, moon.
        '';
      }
      {
        plugin = lualine-nvim;
        type = "lua";
        config = ''
          require("lualine").setup()
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
          g.loaded_netrw = 1
          g.loaded_netrwPlugin = 1
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
        plugin = which-key-nvim;
        type = "lua";
        config = ''
          local wk = require("which-key")
          wk.register(mappings, opts)
        '';
      }
      {
        plugin = nvim-autopairs;
        type = "lua";
        config = ''
          require('nvim-autopairs').setup({
            disable_filetype = { "TelescopePrompt" , "vim" },
          })
        '';
      }
      {
        plugin = copilot-lua;
        type = "lua";
        config = ''
          require("copilot").setup({
           --  panel = { enabled = false },
           --  suggestion = { enabled = false },
          })
        ''; 
      }
      {
        plugin = cmp-spell;
        type = "lua";
        config = ''
          o.spell = true
          o.spelllang = { 'en_us' }
        '';
      }
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = ''
          local capabilities = require('cmp_nvim_lsp').default_capabilities()
          local lspconfig = require("lspconfig")
          lspconfig.tsserver.setup({
            capabilities = capabilities
          })
          -- lspconfig.html.setup({
          --   capabilities = capabilities
          -- })
          lspconfig.lua_ls.setup({
            capabilities = capabilities
          })

          k("n", "K", vim.lsp.buf.hover, {})
          k("n", "<leader>gd", vim.lsp.buf.definition, {})
          k("n", "<leader>gr", vim.lsp.buf.references, {})
          k("n", "<leader>ca", vim.lsp.buf.code_action, {})

        '';
      }
      {
        plugin = nvim-cmp;
        type = "lua";
        config = ''
          local cmp = require("cmp")
          local luasnip = require("luasnip")
          local lspkind = require("lspkind")
          require("luasnip.loaders.from_vscode").lazy_load()
          cmp.setup({
            completion = {
              completeopt = "menu,menuone,preview,noselect",
            },
            snippet = { -- configure how nvim-cmp interacts with snippet engine
              expand = function(args)
                luasnip.lsp_expand(args.body)
              end,
            },
            mapping = cmp.mapping.preset.insert({
              ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
              ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
              ["<C-b>"] = cmp.mapping.scroll_docs(-4),
              ["<C-f>"] = cmp.mapping.scroll_docs(4),
              ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
              ["<C-e>"] = cmp.mapping.abort(), -- close completion window
              ["<CR>"] = cmp.mapping.confirm({ select = false }),
            }),
            -- sources for autocompletion
            sources = cmp.config.sources({
              -- { name = "copilot" },
              { name = "nvim_lsp" },
              { name = "luasnip" }, -- snippets
              { name = "buffer" }, -- text within current buffer
              { name = "path" }, -- file system paths
            }),
            -- configure lspkind for vs-code like pictograms in completion menu
            formatting = {
              format = lspkind.cmp_format({
                maxwidth = 50,
                ellipsis_char = "...",
              }),
            },
          })
       '';
      }
    ];
  };
}
