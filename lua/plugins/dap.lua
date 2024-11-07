return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			{ "rcarriga/nvim-dap-ui" },
			{ "nvim-neotest/nvim-nio" },
			{ "theHamsta/nvim-dap-virtual-text" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-registry" },
			{ "jay-babu/mason-nvim-dap.nvim" },
			{
				"microsoft/vscode-js-debug",
				-- run in terminal and install "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
			},
		},

		keys = function()
			local dap = require("dap")
			local dapui = require("dapui")
			return {
				-- Basic debugging keymaps, feel free to change to your liking!
				{ "<F5>", dap.continue, desc = "Debug: Start/Continue" },
				{ "<F1>", dap.step_into, desc = "Debug: Step Into" },
				{ "<F2>", dap.step_over, desc = "Debug: Step Over" },
				{ "<F3>", dap.step_out, desc = "Debug: Step Out" },
				{ "<leader>b", dap.toggle_breakpoint, desc = "Debug: Toggle Breakpoint" },
				{
					"<leader>B",
					function()
						dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
					end,
					desc = "Debug: Set Breakpoint",
				},
				{ "<F7>", dapui.toggle, desc = "Debug: See last session result." },
			}
		end,
		config = function()
			local dap, dapui = require("dap"), require("dapui")
			require("mason-nvim-dap").setup({
				automatic_installation = true,
				handlers = {},
				ensure_installed = {
					"js-debug-adapter",
				},
			})

			dapui.setup({
				icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
				controls = {
					icons = {
						pause = "⏸",
						play = "▶",
						step_into = "⏎",
						step_over = "⏭",
						step_out = "⏮",
						step_back = "b",
						run_last = "▶▶",
						terminate = "⏹",
						disconnect = "⏏",
					},
				},
			})

			dap.listeners.after.event_initialized["dapui_config"] = dapui.open
			dap.listeners.before.event_terminated["dapui_config"] = dapui.close
			dap.listeners.before.event_exited["dapui_config"] = dapui.close
		end,
	},
	{
		"mxsdev/nvim-dap-vscode-js",
		dependencies = { "mfussenegger/nvim-dap" },
		opts = function()
			require("dap-vscode-js").setup({
				node_path = "/home/mvds/.local/share/mise/installs/node/latest/bin/node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
			  debugger_path = "/home/mvds/debugger/js-debug", -- Path to vscode-js-debug installation.
				debugger_cmd = {"/home/mvds/.local/share/mise/installs/node/latest/bin/node",'/home/mvds/debugger/js-debug/src/dapDebugServer.js'}, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
				adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
				-- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
				-- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
				-- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
			})
			for _, language in ipairs({ "typescript", "javascript" }) do
				require("dap").configurations[language] = {
					{
						{
							type = "pwa-node",
							request = "launch",
							name = "Launch file",
							program = "${file}",
							cwd = "${workspaceFolder}",
						},
						{
							type = "pwa-node",
							request = "attach",
							name = "Attach",
							processId = require("dap.utils").pick_process,
							cwd = "${workspaceFolder}",
						},
					},
				}
			end
		end,
	},
}
