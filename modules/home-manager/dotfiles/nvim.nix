{ config, pkgs, ... }: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      telescope-nvim # Telescope is a highly extendable fuzzy finder over lists.
      comment-nvim # Comment out lines of code based on the file type.
      nvim-ts-context-commentstring # Set the commentstring based on the cursor location in the file.
      nvim-web-devicons # Show file icons in Nvim.
      gruvbox-nvim # A retro groove color scheme for Neovim.
      tokyonight-nvim # A dark color scheme for Neovim.
      onedark-nvim # A dark color scheme for Neovim.
      lualine-nvim # A light and configurable statusline/tabline plugin for Neovim written in Lua.
      toggleterm-nvim # A plugin for toggling terminals in Neovim.
      harpoon2 # A navigation utility plugin for Neovim.
      undotree # A plugin for visualizing undo history.
      copilot-vim # A plugin for generating code with GitHub Copilot.
      rose-pine # A color scheme for Neovim.
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
      vim-fugitive # A Git wrapper for Neovim.
      {
        plugin = (nvim-treesitter.withPlugins (p: [
          p.tree-sitter-nix 
          p.tree-sitter-vim
          p.tree-sitter-bash
          p.tree-sitter-lua
          p.tree-sitter-python
          p.tree-sitter-c
          p.tree-sitter-rust
          p.tree-sitter-c
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

    extraLuaConfig = ''
      vim.g.mapleader = " "  -- Set the global leader key to the space bar. The leader key is used in combination with other keys for custom key mappings.
      vim.g.maplocalleader = ' '  -- Set the local leader key to the space bar. The local leader can be used for buffer-local key mappings.

      -- Lualine
      require('lualine').setup()  -- Initialize Lualine with default settings.

      -- Colorscheme configuration
      require('rose-pine').setup({
        disable_background = true
      })

      function ColorMyPencils(color) 
      	color = color or "rose-pine"
      	vim.cmd.colorscheme(color)
      	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      end

      ColorMyPencils() 
      
      -- Comment configuration
      require('Comment').setup() -- Initialize Comment with default settings.

      vim.g.skip_ts_context_commentstring_module = true
      
      -- Toggleterm configuration
      require("toggleterm").setup{ -- Initialize Toggleterm with default settings.
  	    size = 20,
       	open_mapping = [[<c-\>]],
       	hide_numbers = true,
       	shade_filetypes = {},
       	shade_terminals = true,
       	shading_factor = 2,
       	start_in_insert = true,
       	insert_mappings = true,
       	persist_size = true,
       	direction = "float",
       	close_on_exit = true,
       	shell = vim.o.shell,
       	float_opts = {
       		border = "curved",
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

      -- Telescope configuration      
      local builtin = require('telescope.builtin')  -- Load the Telescope built-in functions.
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})  -- Map <leader>ff to Telescope find_files function.
      vim.keymap.set('n', '<leader>fr', builtin.live_grep, {})  -- Map <leader>fr to Telescope live_grep function.
      vim.keymap.set('n', '<leader>fg', builtin.git_files, {})  -- Map <leader>fg to Telescope git_files function.
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})  -- Map <leader>fb to Telescope buffers function.
      vim.keymap.set('n', '<leader>lsd', builtin.lsp_definitions{})  -- Map <leader>lsd to Telescope lsp_definitions function.
      vim.keymap.set('n', '<leader>lsi', builtin.lsp_implementations{}) -- Map <leader>lsi to Telescope lsp_implementations function.
      vim.keymap.set('n', '<leader>lsl', builtin.lsp_code_actions{}) -- Map <leader>lsl to Telescope lsp_code_actions function.
      vim.keymap.set('n', '<leader>lst', builtin.lsp_type_definitions{}) -- Map <leader>lst to Telescope lsp_type_definitions function.

      -- Treesitter configuration
      require'nvim-treesitter.configs'.setup {  -- Initialize Treesitter with a configuration table.
        ensure_installed = {}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
        auto_install = false, -- if true, automatically install parsers for all languages
        highlight = { enable = true }, -- false will disable the whole extension
        indent = { enable = true }, -- false will disable the whole extension
      }

      -- Harpoon configuration
      local harpoon = require("harpoon")  -- Load the Harpoon module.
      harpoon:setup()  -- Initialize Harpoon with default settings.
      vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end)  -- Map <leader>a to append the current file to Harpoon list.
      vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)  -- Map <C-e> to toggle Harpoon quick menu.
      vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)  -- Map <C-h> to select the first item in Harpoon list.
      vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)  -- Map <C-t> to select the second item in Harpoon list.
      vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)  -- Map <C-n> to select the third item in Harpoon list.
      vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)  -- Map <C-s> to select the fourth item in Harpoon list.
      
      vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end) -- Map <C-S-P> to select the previous item in Harpoon list.
      vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end) -- Map <C-S-N> to select the next item in Harpoon list.

      -- Undotree configuration
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)  -- Map <leader>u to toggle Undotree.

      -- Fugitive configuration
      vim.keymap.set("n", "<leader>gs", vim.cmd.Git)  -- Map <leader>gs to Git status (Fugitive plugin required).
      
      -- Key remappings
      vim.keymap.set("n", "<leader>pv", vim.cmd.Ex) -- Open the command line window
      
      vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- Move the current line down in visual mode.
      vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- Move the current line up in visual mode.

      vim.keymap.set("n", "J", "mzJ`z") -- Join the current line with the line below.
      vim.keymap.set("n", "<C-d>", "<C-d>zz") -- Scroll down half a page.
      vim.keymap.set("n", "<C-u>", "<C-u>zz") -- Scroll up half a page.
      vim.keymap.set("n", "n", "nzzzv") -- Center the cursor after jumping to the next match.
      vim.keymap.set("n", "N", "Nzzzv") -- Center the cursor after jumping to the previous match.

      vim.keymap.set("x", "<leader>p", [["_dP]]) -- Paste over the current selection.

      vim.keymap.set({"n", "v"}, "<leader>y", [["+y]]) -- Copy to the system clipboard.
      vim.keymap.set("n", "<leader>Y", [["+Y]]) -- Copy to the system clipboard until the end of the line.
      vim.keymap.set({"n", "v"}, "<leader>d", [["_d]]) -- Cut to the system clipboard.

      vim.keymap.set("n", "Q", "<nop>") -- Disable the Ex mode.
      vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>") -- Open a new Tmux window with the tmux-sessionizer command.
      vim.keymap.set("n", "<leader>f", vim.lsp.buf.format) -- Format the current buffer.

      vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz") -- Jump to the next quickfix item.
      vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz") -- Jump to the previous quickfix item.
      vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz") -- Jump to the next location list item.
      vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz") -- Jump to the previous location list item.

      vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]) -- Replace the current word with the word under the cursor.
      vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true }) -- Make the current file executable.

      -- General configuration options
      
      vim.opt.termguicolors = true -- Enable 24-bit RGB color support.

      vim.opt.guicursor = "" -- Set the cursor to a vertical bar.

      vim.opt.nu = true -- Show line numbers.
      vim.opt.relativenumber = true -- Show relative line numbers.
 
      vim.opt.tabstop = 4 -- Set the tabstop to 2 spaces.
      vim.opt.softtabstop = 4 -- Set the softtabstop to 2 spaces.
      vim.opt.shiftwidth = 4 -- Set the shiftwidth to 2 spaces.
      vim.opt.expandtab = true -- Use spaces instead of tabs.

      vim.opt.smartindent = true -- Enable smart indentation.
      vim.opt.smartcase = true  -- Enable smart case.
      vim.opt.autoread = true -- 

      vim.opt.mouse = "a" -- Enable mouse support.  
      vim.o.clipboard = 'unnamedplus' -- Use the system clipboard.

      vim.opt.wrap = false -- Disable line wrapping.

      vim.opt.swapfile = false -- Disable swap files.
      vim.opt.backup = false -- Disable backup files.
      vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir" -- Set the undodir to ~/.vim/undodir.
      vim.opt.undofile = true -- Enable persistent undo.

      vim.opt.hlsearch = false -- Disable search highlighting.
      vim.opt.incsearch = true -- Enable incremental search.

      vim.opt.termguicolors = true -- Enable 24-bit RGB color support.

      vim.opt.scrolloff = 8 -- Set the scrolloff to 8 lines.
      vim.opt.signcolumn = "yes" -- Always show the sign column.
      vim.opt.isfname:append("@-@") -- Add the @ character to the list of valid filename characters.

      vim.opt.updatetime = 500 -- Set the updatetime to 500ms.

      -- vim.opt.colorcolumn = "80" -- Set the colorcolumn to 80 characters.
      -- <F7><F7><F7><F7><F7><F7><F7><F7><F7><F7><F7>derw<F6><F5>7<F5>7<F5>7<F5>7<F5>7<F5>7<F5>7<F5>7<F5>7<F5>7<F5>7<F5>7<F5>7<F5>7<F5>7<F5>7<F5>7<F5>7<F5>7<F5>7<F5>7<F5>7<F5>7<F5>7<F5>7<F5>7<F5>7<F5>7<F5>7<F5>7<F5><F5><F5><F5>vim. cmd ("colorscheme gruvbox") -- Set the color scheme to gruvbox.
      '';
  };
}
