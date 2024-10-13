local M = {}
vim.api.nvim_create_user_command('Term', function ()
    -- Этап 1 -- Общие переменные для работы до запуска
    local save_name_file = vim.fn.expand('%:p') -- Сохранение имени файла для запуска команды javac 
    local save_full_path_to_file_for_cd = vim.fn.expand('%:p') -- Сохранение полного пути для команды cd чтобы перейти в каталог java для запуска программы
	local save_full_path_to_file_for_save_class = vim.fn.expand('%:p:h') -- Сохранение полного пути без последнего элемента, последним элементом будет выступать тут save_name_class, который определит имя класса и вследсвии я кодом соединю эти строки и получу правильный запуск команды
	local save_name_class = vim.fn.expand('<cexpr>') -- Сохранение имени класса, которое будет использоваться при запуске программы для того, чтобы избежать ошибки, которая возникнет если у нас в файле будет несколько классов и луа нужно будет определить какую именно подставлять в выражение для запуска

    -- Этап 2 -- Открытие терминала и его настройка
    vim.api.nvim_command('belowright new') -- Создание ,буффера в горизонтальном сплите
    vim.api.nvim_command('resize -10') -- Изменение размера буффера 
    vim.api.nvim_command('terminal') -- Вход в терминал
    vim.api.nvim_feedkeys('A', 'n', false) -- Вход в режим вставки в терминале для ввода команд
    vim.api.nvim_buf_set_name(0, 'Terminal') -- Изменение имени буффера(опционально)
    -- vim.api.nvim_chan_send(vim.b.terminal_job_id, "clear\n") -- Очистка терминала от предыдущих выводов 

    -- Этап 3 -- Компиляция и запись вывода
    vim.fn.system("javac " .. save_name_file .. "\n") -- Компиляция исходника 
	-- Компиляция проихсодит именно через vim.fn.system так как эта функция позволит вернуть значение для последующей проверки в vim.v.shell_error, но при этом команда будет выполняться в системе, а не в неовим терминале, поэтому если возникает ошибка при компиляции чтобы ее отобразить надо запустить компиляцию еще раз но уже при помощи nvim_chan_send
	local compile_status = vim.v.shell_error -- Получаем статус завершения команды

	-- Этап 4 -- Проверка вывода компиляции
	if compile_status == 0 then
		-- Если ошибок нет, то выполняется следующий код
		local path_to_java = save_full_path_to_file_for_cd:match("(.*src/main/java)") -- Получаем полный путь от корня системы до java для того, чтобы можно было запустить java ...
		vim.api.nvim_chan_send(vim.b.terminal_job_id, "cd " .. path_to_java .. "\n") -- Переход в директорию java для запуска
		vim.api.nvim_chan_send(vim.b.terminal_job_id, "clear\n") -- Очистка терминала

		local replaced_text_in_dot = string.gsub(save_full_path_to_file_for_save_class, "/", ".") -- Замена / на .
		local com = "com" -- Начало пути с com
		local start_pos = replaced_text_in_dot:find(com) -- Поиск позиции com
		local str_sub_text_in_dot = replaced_text_in_dot:sub(start_pos) -- Получение полного пути для java
		vim.api.nvim_chan_send(vim.b.terminal_job_id, "java " .. str_sub_text_in_dot .. "." .. save_name_class .. "\n") -- Запуск программы
	else
		-- Если ошибки есть, то выводим слудующее
		vim.api.nvim_chan_send(vim.b.terminal_job_id, "javac " .. save_name_file .. "\n") -- Компиляция для показа ошибки

	end
end, {})

vim.keymap.set('n', '<M-j>', ':w<CR>:Term<CR>', {noremap = true, silent = true}) -- Горячая клавиша для запуска терминала


-- Перейти к имени класса 
vim.api.nvim_create_user_command('GoClassName', function ()
	vim.api.nvim_win_set_cursor(0, {1,0}) -- Изменим положение курсора 
	vim.api.nvim_command('/class') -- Находим слово class 
	vim.api.nvim_command('normal! n') -- Переходим на слово class 
	vim.api.nvim_command('normal! w') -- Переходим на имя класса 
end, {})

vim.keymap.set('i', '<M-k>', '<Esc>:w<CR>:GoClassName<CR>', {noremap = true, silent = true})
vim.keymap.set('n', '<M-k>', ':w<CR>:GoClassName<CR>', {noremap = true, silent = true})


-------------------------------
-- HotKey for close terminal -- 
-------------------------------
vim.keymap.set('t', '<M-;>', function ()
	vim.api.nvim_chan_send(vim.b.terminal_job_id, 'exit\n')
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<CR>', true, false, true), 'n', false)
	vim.api.nvim_command('bd!')
end, {silent = true, noremap = true})

return M

