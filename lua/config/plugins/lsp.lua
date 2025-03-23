return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'folke/lazydev.nvim', -- Configures lua lsp
        ft = 'lua',
        opts = {
          library = {
            { path = 'luvit-meta/library',      words = { 'vim%.uv' } },
            { path = '/usr/share/awesome/lib/', words = { 'awesome' } },
          },
        },
      },
      { 'Bilal2453/luvit-meta',                        lazy = true },
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      { 'j-hui/fidget.nvim',                           opts = {} },
      { 'https://git.sr.ht/~whynothugo/lsp_lines.nvim' },

      { 'elixir-tools/elixir-tools.nvim' },

      'stevearc/conform.nvim',

      'b0o/SchemaStore.nvim',
    },
    config = function()
      if vim.g.obsidian then
        return
      end

      local extend = function(name, key, values)
        local mod = require(string.format('lspconfig.configs.%s', name))
        local default = mod.default_config
        local keys = vim.split(key, '.', { plain = true })
        while #keys > 0 do
          local item = table.remove(keys, 1)
          default = default[item]
        end

        if vim.islist(default) then
          for _, value in ipairs(default) do
            table.insert(values, value)
          end
        else
          for item, value in pairs(default) do
            if not vim.tbl_contains(values, item) then
              values[item] = value
            end
          end
        end
        return values
      end

      local capabilities = nil
      if pcall(require, 'cmp_nvim_lsp') then
        capabilities = require('cmp_nvim_lsp').default_capabilities()
      end

      local lspconfig = require 'lspconfig'


      local servers = {
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              imports = {
                granularity = { group = "module", },
                prefix = "self",
              },
              cargo = {
                buildScripts = { enable = true, },
              },
              procMacro = { enable = true },
              diagnostics = { enable = true },
            }
          }
        },
        ts_ls = {},
        omnisharp = {
          cmd = { "dotnet", vim.fn.stdpath("data") .. "/mason/packages/omnisharp/libexec/OmniSharp.dll" },

          settings = {
            FormattingOptions = {
              -- Enables support for reading code style, naming convention and analyzer
              -- settings from .editorconfig.
              EnableEditorConfigSupport = true,
              -- Specifies whether 'using' directives should be grouped and sorted during
              -- document formatting.
              OrganizeImports = nil,
            },
            MsBuild = {
              -- If true, MSBuild project system will only load projects for files that
              -- were opened in the editor. This setting is useful for big C# codebases
              -- and allows for faster initialization of code navigation features only
              -- for projects that are relevant to code that is being edited. With this
              -- setting enabled OmniSharp may load fewer projects and may thus display
              -- incomplete reference lists for symbols.
              LoadProjectsOnDemand = nil,
            },
            RoslynExtensionsOptions = {
              -- Enables support for roslyn analyzers, code fixes and rulesets.
              EnableAnalyzersSupport = nil,
              -- Enables support for showing unimported types and unimported extension
              -- methods in completion lists. When committed, the appropriate using
              -- directive will be added at the top of the current file. This option can
              -- have a negative impact on initial completion responsiveness,
              -- particularly for the first few completion sessions after opening a
              -- solution.
              EnableImportCompletion = nil,
              -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
              -- true
              AnalyzeOpenDocumentsOnly = nil,
            },
            Sdk = {
              -- Specifies whether to include preview versions of the .NET SDK when
              -- determining which version to use for project loading.
              IncludePrereleases = true,
            },
          },
        },
        jdtls = {},
        bashls = true,
        gopls = {
          manual_install = true,
          settings = {
            gopls = {
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
            },
          },
        },
        lua_ls = {
          server_capabilities = {
            semanticTokensProvider = vim.NIL,
          },
        },
        pyright = true,
        jsonls = {
          server_capabilities = {
            documentFormattingProvider = false,
          },
          settings = {
            json = {
              schemas = require('schemastore').json.schemas(),
              validate = { enable = true },
            },
          },
        },

        -- cssls = {
        --   server_capabilities = {
        --     documentFormattingProvider = false,
        --   },
        -- },

        yamlls = {
          settings = {
            yaml = {
              schemaStore = {
                enable = false,
                url = '',
              },
              -- schemas = require("schemastore").yaml.schemas(),
            },
          },
        },

        clangd = {
          init_options = { clangdFileStatus = true },

          filetypes = { 'c' },
        },

        tailwindcss = {
          init_options = {
            userLanguages = {
              elixir = 'phoenix-heex',
              eruby = 'erb',
              heex = 'phoenix-heex',
            },
          },
          filetypes = extend('tailwindcss', 'filetypes', { 'ocaml.mlx' }),
          settings = {
            tailwindCSS = {
              experimental = {
                classRegex = {
                  [[class: "([^"]*)]],
                  [[className="([^"]*)]],
                },
              },
              includeLanguages = extend('tailwindcss', 'settings.tailwindCSS.includeLanguages', {
                ['ocaml.mlx'] = 'html',
              }),
            },
          },
        },
      }

      local servers_to_install = vim.tbl_filter(function(key)
        local t = servers[key]
        if type(t) == 'table' then
          return not t.manual_install
        else
          return t
        end
      end, vim.tbl_keys(servers))

      require('mason').setup()
      local ensure_installed = {
        'stylua',
        'lua_ls',
        -- "delve",
        -- "tailwind-language-server",
      }

      vim.list_extend(ensure_installed, servers_to_install)
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      for name, config in pairs(servers) do
        if config == true then
          config = {}
        end
        config = vim.tbl_deep_extend('force', {}, {
          capabilities = capabilities,
        }, config)

        lspconfig[name].setup(config)
      end

      local disable_semantic_tokens = {
        lua = true,
      }

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local bufnr = args.buf
          local set = vim.keymap.set
          local autocmd = vim.api.nvim_create_autocmd

          local client = assert(vim.lsp.get_client_by_id(args.data.client_id), 'must have valid client')

          if not client then
            return
          end

          local settings = servers[client.name]
          if type(settings) ~= 'table' then
            settings = {}
          end

          local builtin = require 'telescope.builtin'

          if client:supports_method('textDocument/formatting') then
            autocmd('BufWritePre', {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
              end
            })
          end

          vim.opt_local.omnifunc = 'v:lua.vim.lsp.omnifunc'
          set('n', 'gd', builtin.lsp_definitions, { buffer = 0 })
          set('n', 'gr', builtin.lsp_references, { buffer = 0 })
          set('n', 'gD', vim.lsp.buf.declaration, { buffer = 0 })
          set('n', 'gT', vim.lsp.buf.type_definition, { buffer = 0 })
          set('n', 'K', vim.lsp.buf.hover, { buffer = 0 })

          set('n', '<space>rn', vim.lsp.buf.rename, { buffer = 0, desc = "[R]ename" })
          set('n', '<space>ca', vim.lsp.buf.code_action, { buffer = 0, desc = "[C]ode [A]ction" })
          set('n', '<space>wd', builtin.lsp_document_symbols, { buffer = 0, desc = "[D]ocument symbols" })

          local filetype = vim.bo[bufnr].filetype
          if disable_semantic_tokens[filetype] then
            client.server_capabilities.semanticTokensProvider = nil
          end

          if settings.server_capabilities then
            for k, v in pairs(settings.server_capabilities) do
              if v == vim.NIL then
                ---@diagnostic disable-next-line: cast-local-type
                v = nil
              end

              client.server_capabilities[k] = v
            end
          end
        end,
      })

      require('lsp_lines').setup()
      vim.diagnostic.config { virtual_text = true, virtual_lines = false }

      vim.keymap.set('', '<leader>l', function()
        local config = vim.diagnostic.config() or {}
        if config.virtual_text then
          vim.diagnostic.config { virtual_text = false, virtual_lines = true }
        else
          vim.diagnostic.config { virtual_text = true, virtual_lines = false }
        end
      end, { desc = 'Toggle lsp_lines' })
    end,
  },
}
