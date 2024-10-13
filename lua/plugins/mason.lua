return {
    "williamboman/mason.nvim",
    config = function()
        -- Настройка Mason после его загрузки
        require("mason").setup()

        require("mason-lspconfig").setup({
            ensure_installed = { "clangd", "lua_ls" },  -- Указываем, какие LSP сервера установить через Mason
        })

		-- Setup Kotlin
		require("lspconfig").jdtls.setup {}

        -- Настройка Lua LSP (lua_ls)
        require("lspconfig").lua_ls.setup {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { 'vim', 'map' }
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                        maxPreload = 10000,
                        preloadFileSize = 10000,
                    },
                    telemetry = {
                        enable = false,
                    },
                },
            },
        }
    end,
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    },
}

