return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',      -- Источник автодополнений для LSP
        'hrsh7th/cmp-buffer',        -- Источник для буфера
        'hrsh7th/cmp-path',          -- Источник для файловой системы
        'saadparwaiz1/cmp_luasnip',  -- Источник для сниппетов (luasnip)
        'L3MON4D3/LuaSnip',          -- Плагин для сниппетов
    },
    config = function()
        local cmp = require'cmp'

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            window = {
                completion = cmp.config.window.bordered({
                    -- Настройка ширины окна автодополнения
                    max_width = 60,
                }),
            },
            formatting = {
                fields = {'abbr', 'kind', 'menu'},
                format = function(entry, vim_item)
                    vim_item.abbr = string.sub(vim_item.abbr, 1, 60) -- Ограничение длины текста до 60 символов
                    return vim_item
                end,
            },
            completion = {
                -- Максимальное количество предложений
                completeopt = 'menu,menuone,noinsert',
            },
            experimental = {
                ghost_text = true, -- Показать т.н. "призрачный" текст для предложения
            },
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'buffer' },
                { name = 'path' },
                { name = 'luasnip' }, -- если вы используете luasnip
            }),
            mapping = {
                ['<S-Tab>'] = cmp.mapping.select_prev_item(),
                ['<Tab>'] = cmp.mapping.select_next_item(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Подтверждение выбранного элемента
                ['<C-e>'] = cmp.mapping.abort(), -- Отменить автодополнение
            },
        })

        -- Опция для ограничения количества видимых предложений в меню
        vim.o.pumheight = 8
    end,
}
