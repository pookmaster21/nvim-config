local plugins = {
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                -- rust
                "rust-analyzer",
                -- go
                "gopls",
                "gofumpt",
                "goimports-reviser",
                "golines",
                "gomodifytags",
                -- python
                "black",
                "debugpy",
                "mypy",
                "ruff",
                "pyright",
                -- c
                "clangd",
                "clang-format",
                "codelldb",
                -- js + ts
                "typescript-language-server",
                "eslint-lsp",
                "prettier",
                "js-debug-adapter",
                -- java
                "jdtls",
            },
        },
    },
    {
        "rcarriga/nvim-dap-ui",
        event = "VeryLazy",
        dependencies = "mfussenegger/nvim-dap",
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            dapui.setup()
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end
    },
    {
        'akinsho/flutter-tools.nvim',
        event = "VeryLazy",
        dependencies = {
            'nvim-lua/plenary.nvim',
            'stevearc/dressing.nvim', -- optional for vim.ui.select
        },
        config = true,
    },
    {
        "mfussenegger/nvim-jdtls",
        ft = {"java"},
    },
    {
        "preservim/tagbar",
        event = "VeryLazy",
        config = function ()
            require("core.utils").load_mappings("tagbar")
        end,
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        event = "VeryLazy",
        dependencies = {
            "williamboman/mason.nvim",
            "mfussenegger/nvim-dap",
        },
        opts = {
            handlers = {},
        },
    },
    {
        "mfussenegger/nvim-dap",
        config = function()
            require("core.utils").load_mappings("dap")
        end,
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        event = "VeryLazy",
        opts = function()
            return require "custom.configs.null-ls"
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            require "plugins.configs.lspconfig"
            require "custom.configs.lspconfig"
        end,
    },
    {
        "rust-lang/rust.vim",
        ft = "rust",
        init = function ()
            vim.g.rustfmt_autosave = 1
        end
    },
    {
        "simrat39/rust-tools.nvim",
        ft = "rust",
        dependencies = "neovim/nvim-lspconfig",
        opts = function ()
            return require("custom.configs.rust-tools")
        end,
        config = function (_, opts)
            require('rust-tools').setup(opts)
        end,
    },
    {
        "saecki/crates.nvim",
        ft = {"rust", "toml"},
        dependencies = "hrsh7th/nvim-cmp",
        config = function(_, opts)
            local crates = require('crates')
            crates.setup(opts)
            crates.show()
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        opts = function()
            local M = require("plugins.configs.cmp")
            table.insert(M.sources, {name = "crates"})
            return M
        end,
    },
    {
        "mfussenegger/nvim-dap-python",
        ft = "python",
        dependencies = {
            "mfussenegger/nvim-dap",
            "rcarriga/nvim-dap-ui",
        },
        config = function(_, _)
            local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
            require("dap-python").setup(path)
            require("core.utils").load_mappings("dap_python")
        end,
    },
    {
        "leoluz/nvim-dap-go",
        ft = "go",
        dependencies = "mfussenegger/nvim-dap",
        config = function(_, opts)
            require("dap-go").setup(opts)
            require("core.utils").load_mappings("dap_go")
        end,
    },
    {
        "olexsmir/gopher.nvim",
        ft = "go",
        config = function(_, opts)
            require("gopher").setup(opts)
            require("core.utils").load_mappings("gopher")
        end,
        build = function()
            vim.cmd [[silent! GoInstallDeps]]
        end,
    },
}
return plugins
