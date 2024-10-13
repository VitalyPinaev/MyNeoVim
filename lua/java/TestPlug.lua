local M = {}
	vim.api.nvim_create_user_command('TestPlug', function ()
		-- Этап 1 -- Общие переменные для работы до запуска
		local save_name_file = vim.fn.expand('%:p') -- Сохранение имени файла для запуска команды javac 
		local save_full_path_to_file_for_cd = vim.fn.expand('%:p') -- Сохранение полного пути для команды cd чтобы перейти в каталог java для запуска программы
		local save_full_path_to_file_for_save_class = vim.fn.expand('%:p:h') -- Сохранение полного пути без последнего элемента, последним элементом будет выступать имя класса
		-- local save_name_class = vim.fn.expand('<cexpr>') -- Сохранение имени класса, которое будет использоваться при запуске программы для того, чтобы избежать ошибки, которая возникнет если у нас в файле будет несколько классов и луа нужно будет определить какую именно подставлять в выражение для запуска

		-- Этап 2 --  Поиск ключевого слова class, если есть ошибки при компиляции перенаправление компиляции в файл и проверка на ошибку psvm
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false) -- Переходим из режима вставки в нормальный 
		vim.api.nvim_win_set_cursor(0, {1, 1}) -- Изменим положение курсора 
		vim.api.nvim_command('/class') -- Находим слово класс и переходим к строке с этим словом
		vim.api.nvim_command('normal! n') -- Переходим к слову class
		vim.api.nvim_command('normal! w') -- Переходим к имени класса
		local save_name_class = vim.fn.expand('<cexpr>') -- Сохранаяем имя класса для запуска программы

		-- Этап 3 -- Открытие терминала и его настройка
    vim.api.nvim_command('belowright new') -- Создание ,буффера в горизонтальном сплите
    vim.api.nvim_command('resize -10') -- Изменение размера буффера 
    vim.api.nvim_command('terminal') -- Вход в терминал
    vim.api.nvim_feedkeys('A', 'n', false) -- Вход в режим вставки в терминале для ввода команд
    vim.api.nvim_buf_set_name(0, 'Terminal') -- Изменение имени буффера(опционально)

		-- Этап 4 -- Компиляция и запись вывода в файл 
		vim.fn.system("javac " .. save_name_file .. "\n") -- Компиляция исходника 
		-- Компиляция проихсодит именно через vim.fn.system так как эта функция позволит вернуть значение для последующей проверки в vim.v.shell_error, но при этом команда будет выполняться в системе, а не в неовим терминале, поэтому если возникает ошибка при компиляции чтобы ее отобразить надо запустить компиляцию еще раз но уже при помощи nvim_chan_send
		local compile_status = vim.v.shell_error -- Получаем статус завершения команды

		-- Этап 5 -- Проверка вывода компиляции
		if compile_status == 0 then
			-- Если ошибок нет(а их не будет когда в исходнике один класс и в нем есть psvm), то выполняется следующий код
			local path_to_java = save_full_path_to_file_for_cd:match("(.*src/main/java)") -- Получаем полный путь от корня системы до java для того, чтобы можно было запустить java ...
			vim.api.nvim_chan_send(vim.b.terminal_job_id, "cd " .. path_to_java .. "\n") -- Переход в директорию java для запуска
			vim.api.nvim_chan_send(vim.b.terminal_job_id, "clear\n") -- Очистка терминала

			local replaced_text_in_dot = string.gsub(save_full_path_to_file_for_save_class, "/", ".") -- Замена / на .
			local com = "com" -- Начало пути с com
			local start_pos = replaced_text_in_dot:find(com) -- Поиск позиции com
			local str_sub_text_in_dot = replaced_text_in_dot:sub(start_pos) -- Получение полного пути для java
			vim.api.nvim_chan_send(vim.b.terminal_job_id, "java " .. str_sub_text_in_dot .. "." .. save_name_class .. "\n") -- Запуск программы

			-- Если будет ошибка, то записываем ее в log.txt и считываем ее 
			elseif compile_status ~= 0 then
				vim.fn.system("javac " .. save_name_file .. " > log.txt 2>&1")-- Компиляция исходника и сохранение ошибки
				-- Считываем ошибку из log.txt
				local file = io.open(save_full_path_to_file_for_save_class .. "/" .. "log.txt", "r") -- Открываем файл для чтения 
				local content_file = file:read("*a") -- Считываем весь текст и сохраняем его
				file:close() -- Закрываем файл
				local read_content_file = content_file:match('public static void main')
				if read_content_file then
					vim.api.nvim_chan_send(vim.b.terminal_job_id, "exit\n") -- Закрываем терминал для перехода к следующему классу 
					vim.api.nvim_command('normal! n') -- Переходим к следующему имени класса 
				end
		end


	end, {})
return M
