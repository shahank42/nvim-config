-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'EdenEast/nightfox.nvim',

    config = function()
      local ok_status, NightFox = pcall(require, 'nightfox')

      if not ok_status then
        return
      end

      NightFox.setup {
        options = {
          transparent = true,
        },
      }

      -- vim.cmd [[ colorscheme carbonfox ]]
    end,
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine-moon',

    config = function()
      local ok_status, RosePine = pcall(require, 'rose-pine')

      if not ok_status then
        return
      end

      RosePine.setup {
        styles = {
          italic = false,
          -- transparency = true,
        },
      }

      -- vim.cmd [[ colorscheme rose-pine]]
    end,
  },
  { 'miikanissi/modus-themes.nvim', priority = 1000 },
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {},
  },
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
  {
    'windwp/nvim-ts-autotag',
  },
  {
    'luckasRanarison/tailwind-tools.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {}, -- your configuration
  },
  {
    'ray-x/go.nvim',
    dependencies = { -- optional packages
      'ray-x/guihua.lua',
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('go').setup {
        lsp_codelens = false,
        lsp_inlay_hints = {
          enable = false,
        },
      }
    end,
    event = { 'CmdlineEnter' },
    ft = { 'go', 'gomod' },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
  { 'dsznajder/vscode-es7-javascript-react-snippets' },
  {
    'neovim/nvim-lspconfig',
    opts = {
      -- @type lspconfig.options
      servers = {
        intelephense = {
          filetypes = { 'php', 'blade' },
          settings = {
            intelephense = {
              filetypes = { 'php', 'blade' },
              files = {
                associations = { '*.php', '*.blade.php' }, -- Associating .blade.php files as well
                maxSize = 5000000,
              },
            },
          },
        },
      },
    },
  },
  {
    'jwalton512/vim-blade',
  },
  {
    'ggandor/leap.nvim',
    config = function()
      local ok_status, leap = pcall(require, 'leap')

      if not ok_status then
        return
      end

      leap.create_default_mappings()
    end,
  },
  {
    'adalessa/laravel.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'tpope/vim-dotenv',
      'MunifTanjim/nui.nvim',
      'nvimtools/none-ls.nvim',
    },
    cmd = { 'Sail', 'Artisan', 'Composer', 'Npm', 'Yarn', 'Laravel' },
    keys = {
      { '<leader>la', ':Laravel artisan<cr>' },
      { '<leader>lr', ':Laravel routes<cr>' },
      { '<leader>lm', ':Laravel related<cr>' },
    },
    event = { 'VeryLazy' },
    config = true,
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    ft = { 'rust' },
    opts = {
      server = {
        on_attach = function(_, bufnr)
          vim.keymap.set('n', '<leader>cR', function()
            vim.cmd.RustLsp 'codeAction'
          end, { desc = 'Code Action', buffer = bufnr })
          vim.keymap.set('n', '<leader>dr', function()
            vim.cmd.RustLsp 'debuggables'
          end, { desc = 'Rust Debuggables', buffer = bufnr })
        end,
        default_settings = {
          -- rust-analyzer language server configuration
          ['rust-analyzer'] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              buildScripts = {
                enable = true,
              },
            },
            -- Add clippy lints for Rust.
            checkOnSave = true,
            procMacro = {
              enable = true,
              ignored = {
                ['async-trait'] = { 'async_trait' },
                ['napi-derive'] = { 'napi' },
                ['async-recursion'] = { 'async_recursion' },
              },
            },
          },
        },
      },
    },
    config = function(_, opts)
      vim.g.rustaceanvim = vim.tbl_deep_extend('keep', vim.g.rustaceanvim or {}, opts or {})
      if vim.fn.executable 'rust-analyzer' == 0 then
        LazyVim.error('**rust-analyzer** not found in PATH, please install it.\nhttps://rust-analyzer.github.io/', { title = 'rustaceanvim' })
      end
    end,
  },
}
