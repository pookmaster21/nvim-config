local config = require("plugins.configs.lspconfig")

local on_attach = config.on_attach
local capabilities = config.capabilities

local lspconfig = require("lspconfig")

local servers = {
    -- rust
    "rust_analyzer",
    -- ts + js + html
    "tsserver",
    "eslint",
    -- css
    "tailwindcss",
    "cssls",
    -- docker
    "dockerls",
    -- ruby
    "ruby_ls",
    -- python
    "pyright",
    -- c + cpp
    "clangd",
    -- java
    "jdtls",
}

for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
    }
end

lspconfig.gopls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        gopls = {
            gofumpt = true,
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
                unusedparams = true,
            },
        },
    },
}

