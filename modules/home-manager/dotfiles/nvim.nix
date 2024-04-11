{ config, pkgs, lib, ... }: {
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
      local opt = vim.opt
      local cmd = vim.cmd
      local api = vim.api
      local kmap = vim.keymap.set
      local ons = { noremap = true, silent = true }
      
      -- leader key configuration
      g.mapleader = " "
      g.maplocalleader = ' '
      kmap("", "<Space>", "<Nop>", ons)

      -- tab & indentation
      opt.tabstop = 2
      opt.shiftwidth = 2
      opt.softtabstop = 2
      opt.expandtab = true
      -- opt.smarttab = true
      opt.smartindent = true
      -- opt.autoindent = true
      -- opt.cpoptions = 'I'
      -- opt.breakindent = true

      -- disable swap files
      opt.swapfile = false
      opt.backup = false

      -- undo settings
      opt.undofile = true
      opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

      -- wrap lines
      opt.wrap = false
      opt.linebreak = true

      -- fold settings
      opt.foldmethod = "syntax"
      opt.foldlevel = 1
      opt.foldnestmax = 10
      opt.foldenable = false
      opt.foldcolumn = "1"

      -- file format and encodinf UTF-8
      opt.fileencoding = "utf-8"
      opt.fileformats = unix

      -- auto reload files changed outside of vim
      opt.autoread = true

      -- display relative line number
      opt.number = true
      opt.relativenumber = true

      -- search settings
      opt.smartcase = true
      opt.ignorecase = true
      opt.hlsearch = false
      opt.incsearch = true

      -- appearance
      opt.termguicolors = true
      opt.mouse = "a"
      opt.mousehide = true
      opt.signcolumn = "yes"
      opt.guicursor = ""
      opt.scrolloff = 8
      opt.sidescrolloff = 8
      -- opt.colorcolumn = "80"
      opt.updatetime = 300
      opt.timeout = true
      opt.timeoutlen = 300
      opt.cursorline = true
      opt.showmatch = true
      opt.backspace = 'indent,eol,start'

      -- split windows below and to the right
      opt.splitbelow = true
      opt.splitright = true
      
      -- Spell checking
      opt.spelllang = "en_us"

      -- key mappings
      -- kmap("n", "<leader>pv", vim.cmd.Ex)
      kmap("n", "<leader>q", vim.cmd.quit)
      kmap("n", "<leader>w", vim.cmd.write)

      -- move lines
      kmap("v", "J", ":m '>+1<CR>gv=gv", ons)
      kmap("v", "K", ":m '<-2<CR>gv=gv", ons)

      -- join lines without inserting a space
      kmap("n", "J", "mzJ`z", ons)

      -- paste over the current selection
      kmap("x", "<leader>p", [["_dP]], ons)

      -- copy/cut to the system clipboard
      kmap({"n", "v"}, "<leader>y", [["+y]], ons)
      kmap({"n", "v"}, "<leader>d", [["_d]], ons)
      kmap("n", "<leader>Y", [["+Y]], ons)
      opt.clipboard = 'unnamedplus'

      -- press jk/kj fast to exit insert mode 
      kmap("i", "jk", "<ESC>", ons)
      kmap("i", "kj", "<ESC>", ons)

      -- move windows with Ctrl + hjkl keys
      kmap("n", "<C-h>", "<C-w>h", ons)
      kmap("n", "<C-j>", "<C-w>j", ons)
      kmap("n", "<C-k>", "<C-w>k", ons)
      kmap("n", "<C-l>", "<C-w>l", ons)
      
      -- split windows horizontally and vertically
      kmap("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
      kmap("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
      
      kmap("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
      kmap("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })
       
      -- navigate buffers
      kmap("n", "<S-l>", ":bnext<CR>", ons)
      kmap("n", "<S-h>", ":bprevious<CR>", ons)

      -- resize with arrows
      kmap("n", "<C-Up>", ":resize -2<CR>", ons)
      kmap("n", "<C-Down>", ":resize +2<CR>", ons)
      kmap("n", "<C-Left>", ":vertical resize -2<CR>", ons)
      kmap("n", "<C-Right>", ":vertical resize +2<CR>", ons)

      -- scroll up/down half a page
      kmap("n", "<C-d>", "<C-d>zz")
      kmap("n", "<C-u>", "<C-u>zz")

      -- center the cursor when searching
      kmap("n", "n", "nzzzv")
      kmap("n", "N", "Nzzzv")

      -- disable the Exit mode
      kmap("n", "Q", "<nop>", ons)

      -- replace the current word with the word under the cursor
      kmap("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

      -- make the current file executable
      kmap("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

      -- vim api mappings
      api.nvim_set_keymap('n', "<M-s>", ':so $MYVIMRC<CR>', ons)
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
      dressing-nvim # A plugin for dressing up your Neovim. 
      lspkind-nvim # A plugin for dressing up your Neovim.
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
      cmp-look # A look source for nvim-cmp
      cmp-nvim-lsp # A LSP source for nvim-cmp
      cmp-nvim-lua # A Lua source for nvim-cmp
      luasnip # A snippet engine for Neovim
      friendly-snippets # A collection of snippets for LuaSnip
      trouble-nvim # A plugin for managing Neovim's diagnostics 
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
      #       cmd.colorscheme(color)
      #       api.nvim_set_hl(0, "Normal", { bg = "none" })
      #       api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      #     end
      #     ColorMyPencils()
      #   '';
      # }
      # {
      #   plugin = catppuccin-nvim;
      #   type = "lua";
      #   config = ''
      #     cmd.colorscheme "catppuccin-macchiato"  -- colorscheme latte, frappe, macchiato, mocha
      #
      #   '';
      # }
      {
        plugin = tokyonight-nvim;
        type = "lua";
        config = ''
          cmd.colorscheme "tokyonight-storm"  -- colorscheme storm, night, day, moon.
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
          kmap("n", "<leader>u", vim.cmd.UndotreeToggle)
      	'';
      }
      {
      	plugin = vim-fugitive;
      	type = "lua";
      	config =''
          kmap("n", "<leader>gs", vim.cmd.Git)
          kmap("n", "<leader>gp", ":Git push<CR>")
      	'';
      }	
      {
        plugin = nvim-tree-lua;
        type = "lua";
        config =''
          require("nvim-tree").setup()
          kmap("n", "<leader>tr", ":NvimTreeToggle<CR>")
          g.loaded_netrw = 1
          g.loaded_netrwPlugin = 1
          '';
      }
      {
      	plugin = telescope-nvim;
      	type = "lua";
      	config = ''
          local builtin = require('telescope.builtin')
          kmap('n', '<leader>ff', builtin.find_files, {})
          kmap('n', '<leader>fg', builtin.live_grep, {})
          kmap('n', '<leader>fb', builtin.buffers, {})
          kmap('n', '<leader>fh', builtin.help_tags, {})
    	  '';
      }
      {
      	plugin = harpoon2;
      	type = "lua";
      	config = ''
          local harpoon = require("harpoon")
          harpoon:setup()
          kmap("n", "<leader>ha", function() harpoon:list():append() end)
          kmap("n", "<leader>he", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
          kmap("n", "<leader>h1", function() harpoon:list():select(1) end)
          kmap("n", "<leader>h2", function() harpoon:list():select(2) end)
          kmap("n", "<leader>h3", function() harpoon:list():select(3) end)
          kmap("n", "<leader>h4", function() harpoon:list():select(4) end)
          kmap("n", "<leader>h,", function() harpoon:list():prev() end)
          kmap("n", "<leader>h.", function() harpoon:list():next() end)
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
        plugin = cmp-spell;
        type = "lua";
        config = ''
          opt.spell = true
          opt.spelllang = { 'en_us' }
          '';
      }
      {
        plugin = copilot-lua;
        type = "lua";
        config = ''
          require("copilot").setup({
            -- copilot_node_command = '${lib.getExe pkgs.nodejs}',
            panel = { enabled = false },
            suggestion = { enabled = false },
            snippet = { enabled = true },
          })
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

          kmap("n", "K", vim.lsp.buf.hover, {})
          kmap("n", "<leader>gd", vim.lsp.buf.definition, {})
          kmap("n", "<leader>gr", vim.lsp.buf.references, {})
          kmap("n", "<leader>ca", vim.lsp.buf.code_action, {})

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
              { name = "copilot" },
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
