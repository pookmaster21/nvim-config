local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local opts = {
    sources = {
        -- python
        null_ls.builtins.formatting.black,
        null_ls.builtins.diagnostics.mypy,
        null_ls.builtins.diagnostics.ruff,
        -- c
        null_ls.builtins.formatting.clang_format.with({ extra_args = { "--style={IndentWidth: 4}" } }),
        -- go
        null_ls.builtins.formatting.gofumpt,
        null_ls.builtins.formatting.goimports_reviser,
        null_ls.builtins.formatting.golines,
        -- js + ts
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.formatting.prettier.with({ disabled_filetypes = { "markdown" }, extra_args = { "--tab-width", "4" } }),
    },
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({
                group = augroup,
                buffer = bufnr,
            })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr })
                end,
            })
        end
    end,
}
return opts
