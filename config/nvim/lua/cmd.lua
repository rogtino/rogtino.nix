vim.api.nvim_create_user_command("SwitchTheme", function(tb)
	local theme = tb["args"]
	if theme == "dark" then
		vim.o.background = "dark"
		local previous_theme = vim.g.current_theme
		local tmp_table = vim.tbl_filter(function(it)
			return it ~= previous_theme
		end, vim.g.all_colors[theme])
		local random_selected = tmp_table[math.random(#tmp_table)]
		vim.cmd.colorscheme(random_selected)
		vim.g.current_theme = random_selected
		vim.notify("switching to dark theme: " .. random_selected, vim.log.levels.INFO, {})
	elseif theme == "light" then
		vim.o.background = "light"
		local previous_theme = vim.g.current_theme
		local tmp_table = vim.tbl_filter(function(it)
			return it ~= previous_theme
		end, vim.g.all_colors[theme])
		local random_selected = tmp_table[math.random(#tmp_table)]
		vim.cmd.colorscheme(random_selected)
		vim.g.current_theme = random_selected
		vim.notify("switching to light theme: " .. random_selected, vim.log.levels.INFO, {})
	else
		vim.notify("apply dark or light", vim.log.levels.ERROR, {})
	end
end, { nargs = 1 })

vim.api.nvim_create_user_command("LuaSnipEdit", function()
	require("luasnip.loaders").edit_snippet_files()
end, {})

vim.api.nvim_create_user_command("FindSqlite3", function()
	vim.system({ vim.fn.stdpath("config") .. "/locate-sqlite3.sh" }):wait()
end, {})

vim.api.nvim_create_user_command("ToUnix", function()
	local Job = require("plenary.job")
	local buf_name = vim.api.nvim_buf_get_name(0)
	local res
	Job:new({
		command = "dos2unix",
		args = { "-O", buf_name },
		on_exit = function(j)
			res = j:result()
		end,
	}):sync()
	vim.api.nvim_buf_set_lines(0, 0, -1, true, res)
end, {})

vim.api.nvim_create_user_command("OverseerXmake", function()
	local overseer = require("overseer")
	local main_win = vim.api.nvim_get_current_win()
	overseer.run_template({ name = "xmake" }, function(task)
		if task == nil then
			vim.notify(("WatchRun not supported for filetype " .. vim.bo.filetype), vim.log.levels.ERROR)
		else
			task:add_component({
				"dependencies",
				task_names = { { "shell", cmd = "xmake build" } },
				sequential = true,
			})
			task:add_component({ "restart_on_save", paths = { vim.fn.expand("%:p") } })
			overseer.run_action(task, "70vsplit")
			vim.api.nvim_set_current_win(main_win)
		end
	end)
end, {})
vim.api.nvim_create_user_command("OverseerRunScript", function()
	local overseer = require("overseer")
	local main_win = vim.api.nvim_get_current_win()
	overseer.run_template({ name = "run script" }, function(task)
		if task == nil then
			return vim.notify(("WatchRun not supported for filetype " .. vim.bo.filetype), vim.log.levels.ERROR)
		else
			task:add_component({ "restart_on_save", paths = { vim.fn.expand("%:p") } })
			overseer.run_action(task, "70vsplit")
			vim.api.nvim_set_current_win(main_win)
		end
	end)
end, {})

vim.api.nvim_create_user_command("FormatDisable", function(args)
	if args.bang then
		-- FormatDisable! will disable formatting globally
		vim.g.disable_autoformat = true
	else
		vim.b.disable_autoformat = true
	end
end, {
	desc = "Disable autoformat-on-save",
	bang = true,
})
vim.api.nvim_create_user_command("FormatEnable", function()
	vim.b.disable_autoformat = false
	vim.g.disable_autoformat = false
end, {
	desc = "Re-enable autoformat-on-save",
})
