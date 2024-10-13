local M = {}
	-- Получение общих данных с файла и запись в файл кода для создания autocmd
	vim.api.nvim_create_user_command('AutoTextCode', function ()
		local save_name_file = vim.fn.expand('%:t:r') -- Сохранение имени файла без расширения
		local save_full_path = vim.fn.expand('%:p:h') -- Сохранение полного пути к пакету без имени файла
		local change_path_one_dot = string.gsub(save_full_path, "/", ".") -- Замена у пути / на точки
		local com = "com" -- Шаблон для поиска от какой директории начать путь
		local search_in_path_word_com = change_path_one_dot:find(com) -- Сохраняем этот шаблон директории в численном виде(следующая переменная не принимает строку, поэтому тут конвертируется строка в число)
		local final_path_for_package = change_path_one_dot:sub(search_in_path_word_com) -- Получаем итоговую версию пути для java пакета
		local current_line = vim.api.nvim_win_get_cursor(0)[1]
		vim.api.nvim_buf_set_lines(0, current_line - 1, current_line - 1, false, { "package " .. final_path_for_package .. ";" }) -- Устанавливаем путь к пакету 
		vim.api.nvim_buf_set_lines(0, current_line , current_line , false, { "" }) -- пустая строка
		vim.api.nvim_buf_set_lines(0, current_line + 1, current_line + 1, false, { "public class " .. save_name_file .. " {" }) -- Начало инициализации класса 
		vim.api.nvim_buf_set_lines(0, current_line + 2, current_line + 2, false, { "}"}) -- Устанавливаем закрывающую фигурную скобку
		vim.api.nvim_win_set_cursor(0, {3,0}) -- Установка курсора 
		vim.fn.feedkeys("o", "n") -- Переход на новую строку и вход в режим вставки
	end, {})

	-- Добавление автокоманды, которая будет срабатывать при создании файла с расширением java
	vim.api.nvim_create_autocmd("BufNewFile", { -- Создание автокоманды, она будет выполняться когда создается новый файл при помощи BufNewFile
		pattern = {"*.java"}, -- Шаблон. Данная автокоманда будет применяться к файлам с любым именем и расширением java
		callback = function ()
			vim.api.nvim_command("AutoTextCode") -- Эта команда выполнится когда сработает шаблон
		end
	})
return M
