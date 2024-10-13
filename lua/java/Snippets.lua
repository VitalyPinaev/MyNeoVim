local M = {}

function Create_sp(snippets, full_text)
    vim.api.nvim_create_autocmd('TextChangedI', {
        pattern = {"*.java"},
        callback = function ()
            -- Получаем позицию курсора
            local save_position_cursor = vim.api.nvim_win_get_cursor(0)
            -- Получаем строку под курсором
            local save_text_in_line = vim.api.nvim_buf_get_lines(0, save_position_cursor[1] - 1, save_position_cursor[1], false)
            local save_line = save_text_in_line[1]

            -- Проверяем, существует ли строка и совпадает ли она со сниппетом
            if save_line then
                local find_snip = save_line:match(snippets)
                if find_snip then
                    -- Удаляем сниппет и вставляем полный текст
                    vim.api.nvim_buf_set_text(0, save_position_cursor[1] - 1, 0, save_position_cursor[1] - 1, #save_line, { full_text })
					-- Делаем последние корректировки
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false) -- Переходим из режима вставки в нормальный 
					vim.fn.feedkeys("==", "n") -- Выравниваем код
					vim.fn.feedkeys("$", "n") -- Переходим в конец строки
					vim.fn.feedkeys("i", "n") -- Переходим в режим вставки

                end
            end
        end
    })
end

-- Пример создания сниппетов
Create_sp("psvm", "public static void main(String[] args) {}")
Create_sp("sop", "System.out.println()")

return M

