return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",  -- Эта команда обновит парсеры после установки
    event = {"BufReadPost", "BufNewFile"},  -- Загружать плагин только при открытии файла
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects" -- Если нужно использовать текстовые объекты Tree-sitter
    },
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = { "kotlin", "lua", "python", "cpp" }, -- Языки для которых будут установлены парсеры
        highlight = {
          enable = true,              -- Включить подсветку с помощью Tree-sitter
          additional_vim_regex_highlighting = false, -- Отключить стандартную подсветку Vim
        },
        indent = {
          enable = true,               -- Включить авто-отступы
        },
        -- Добавьте другие модули Tree-sitter, которые вам нужны
      }
    end
  }
}

