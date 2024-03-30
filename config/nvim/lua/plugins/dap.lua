return {
	"mfussenegger/nvim-dap",
	config = function()
		local dap = require("dap")
		dap.adapters.codelldb =
			{ executable = { args = { "--port", "${port}" }, command = "codelldb" }, port = "${port}", type = "server" }
		dap.set_log_level("TRACE")
		dap.adapters.python = { type = "executable", command = "/usr/bin/python", args = { "-m", "debugpy.adapter" } }
		dap.configurations.python = {
			{
				type = "python",
				request = "launch",
				name = "Launch file",
				program = "${file}",
				pythonPath = function()
					local cwd = vim.fn.getcwd()
					if vim.fn.executable((cwd .. "/venv/bin/python")) == 1 then
						return (cwd .. "/venv/bin/python")
					elseif vim.fn.executable((cwd .. "/.venv/bin/python")) == 1 then
						return (cwd .. "/.venv/bin/python")
					else
						return "/usr/bin/python"
					end
				end,
			},
		}
		dap.configurations.cpp = {
			{
				name = "Launch",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", (vim.fn.getcwd() .. "/"), "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
			},
		}
		dap.configurations.c = dap.configurations.cpp
		dap.configurations.rust = dap.configurations.cpp
		vim.fn.sign_define("DapBreakpoint", { text = "🐞" })
		vim.keymap.set(
			"n",
			"<F2>",
			":lua require'persistent-breakpoints.api'.toggle_breakpoint()<CR>",
			{ silent = true }
		)
		vim.keymap.set("n", "<F5>", ":lua require'dap'.continue()<CR>", { silent = true })
		vim.keymap.set("n", "<F8>", ":lua require'dap'.step_over()<CR>", { silent = true })
		vim.keymap.set("n", "<F7>", ":lua require'dap'.step_into()<CR>", { silent = true })
		vim.keymap.set("n", "<F9>", ":lua require'dap'.repl.toggle()<CR>", { silent = true })
		vim.keymap.set("n", "do", ":lua require'dapui'.toggle()<CR>", { silent = true })
	end,
	event = "VeryLazy",
}
