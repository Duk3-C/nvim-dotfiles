return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		---@type any
		local dap = require("dap")
		---@type any
		local dapui = require("dapui")

    dapui.setup()

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		dap.adapters.lldb = {
			type = "server",
			port = "${port}",
			executable = {
				command = "/usr/bin/lldb-vscode",
				args = { "--port", "${port}" },
			},
		}

    dap.adapters.debugpy = {
        type = "executable",
        command = "python3",
        args = { "-m", "debugpy.adapter" },
    }

    local function get_program_path(default_path)
        return function()
            return vim.fn.input("Path to executable: ", default_path, "file")
        end
    end

    dap.configurations.cpp = {
        {
            name = "Launch C++ program",
            type = "lldb",
            request = "launch",
            program = get_program_path(vim.fn.getcwd() .. "/"),
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
            args = {},
            environment = {},
            console = "integratedTerminal",
            sourceLanguages = {"c", "cpp"},
        },
    }

    dap.configurations.zig = {
        {
            name = "Launch Zig program",
            type = "lldb",
            request = "launch",
            program = function()
                return vim.fn.input("Zig executable (zig-out/bin/)", vim.fn.getcwd() .. "/zig-out/bin/", "file")
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
            args = {},
            environment = {},
            console = "integratedTerminal",
            sourceLanguages = {"c", "cpp", "zig"},
        },
    }

    vim.api.nvim_create_autocmd("FileType", {
        pattern = {"python"},
        callback = function()
            local function get_python_program()
                local current_file = vim.fn.expand("%:p")
                if vim.fn.isdirectory(current_file) == 1 then
                    return current_file .. "/main.py"
                end
                return current_file
            end

            table.insert(dap.configurations.python, {
                name = "Debug Python file",
                type = "debugpy",
                request = "launch",
                program = get_python_program,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
                args = {},
                pythonPath = {"${python}"},
                console = "integratedTerminal",
                justMyCode = true,
                environment = {
                    PYTHONPATH = "${workspaceFolder}:$PYTHONPATH"
                },
            })

            table.insert(dap.configurations.python, {
                name = "Debug pytest",
                type = "debugpy",
                request = "launch",
                program = "${file}",
                args = {
                    "-m", "pytest",
                    "--no-header",
                    "-v",
                    "${file}"
                },
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
                pythonPath = {"${python}"},
                console = "integratedTerminal",
                justMyCode = true,
            })
        end,
    })

    vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, {desc = "Toggle breakpoint"})
    vim.keymap.set("n", "<leader>dc", dap.continue, {desc = "Continue"})
    vim.keymap.set("n", "<leader>di", dap.step_into, {desc = "Step into"})
    vim.keymap.set("n", "<leader>do", dap.step_over, {desc = "Step over"})
    vim.keymap.set("n", "<leader>dO", dap.step_out, {desc = "Step out"})
    vim.keymap.set("n", "<leader>dl", dap.run_last, {desc = "Run last"})
		end,
}

