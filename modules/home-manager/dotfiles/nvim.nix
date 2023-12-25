{ config, pkgs, ... }: {
  programs.neovim = {
    enable = true;
    vimAlias = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      telescope-nvim
      vim-airline
      vim-airline-themes
      harpoon2
      undotree
      # tmux-nvim
      # copilot-lua
      copilot-vim
      rose-pine
      lsp-colors-nvim
      lsp-zero-nvim
      nvim-lspconfig
      mason-lspconfig-nvim
      mason-nvim
      nvim-cmp
      cmp-buffer
      cmp-path
      cmp_luasnip
      cmp-nvim-lsp
      cmp-nvim-lua
      luasnip
      friendly-snippets
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
      nvim-treesitter-parsers.zig
      nvim-treesitter-parsers.ocaml
    ];

    extraLuaConfig = ''
      vim.g.mapleader = " "  -- Set the global leader key to the space bar. The leader key is used in combination with other keys for custom key mappings.
      vim.g.maplocalleader = ' '  -- Set the local leader key to the space bar. The local leader can be used for buffer-local key mappings.

      -- Airline configuration
      vim.g.airline_powerline_fonts = 1 -- Use Powerline fonts for Airline.

      vim.g['airline#extensions#line#enabled'] = 1 -- Enable the line extension.
      vim.g['airline#extensions#tabline#show_buffers'] = 0 -- Disable the tabline extension.
      vim.g.airline_theme = 'dark' -- Set the Airline theme to dark.
      vim.g['airline#extensions#hunks#enabled'] = 0 -- Disable the hunks extension.
      vim.g['airline#extensions#branch#enabled'] = 1 -- Enable the branch extension.

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

      -- LSP configuration
      local lsp = require("lsp-zero") -- Load the LSP Zero module.
      lsp.preset("recommended") -- Load the recommended LSP settings.
      
      local cmp = require('cmp') -- Load the nvim-cmp module.
      local cmp_select = {behavior = cmp.SelectBehavior.Select} -- Create a variable to store the cmp.SelectBehavior.Select behavior.
      local cmp_mappings = lsp.defaults.cmp_mappings({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
      })

      cmp_mappings['<Tab>'] = nil
      cmp_mappings['<S-Tab>'] = nil

      -- lsp.setup_nvim_cmp({
      --  mapping = cmp_mappings
      -- })

      lsp.set_preferences({
          suggest_lsp_servers = false,
          sign_icons = {
              error = 'E',
              warn = 'W',
              hint = 'H',
              info = 'I'
          }
      })

      -- Telescope configuration      
      local builtin = require('telescope.builtin')  -- Load the Telescope built-in functions.
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})  -- Map <leader>ff to Telescope find_files function.
      vim.keymap.set('n', '<leader>fr', builtin.live_grep, {})  -- Map <leader>fr to Telescope live_grep function.
      vim.keymap.set('n', '<leader>fg', builtin.git_files, {})  -- Map <leader>fg to Telescope git_files function.
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})  -- Map <leader>fb to Telescope buffers function.

      -- Treesitter configuration
      require'nvim-treesitter.configs'.setup {  -- Initialize Treesitter with a configuration table.
        highlight = {
          enable = true,  -- Enable Treesitter-based syntax highlighting.
        },
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
 
      vim.opt.tabstop = 2 -- Set the tabstop to 2 spaces.
      vim.opt.softtabstop = 2 -- Set the softtabstop to 2 spaces.
      vim.opt.shiftwidth = 2 -- Set the shiftwidth to 2 spaces.
      vim.opt.expandtab = true -- Use spaces instead of tabs.

      vim.opt.smartindent = true -- Enable smart indentation.

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
      '';
  };
}
