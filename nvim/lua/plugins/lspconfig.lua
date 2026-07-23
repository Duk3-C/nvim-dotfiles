return {
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"clangd",
					"zls",
					"pyright",
					"asm_lsp",
					"ast_grep",
					"nil_ls",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			vim.lsp.config.lua_ls = {
        capabilities = capabilities,
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
					},
				},
			}
			vim.lsp.enable("lua_ls")

			vim.lsp.config.clangd = {
				capabilities = capabilities,
				cmd = { "clangd" },
				filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
				root_markers = { ".clangd", "compile_commands.json", "compile_flags.txt", ".git" },
				settings = {
					clangd = {
						fallbackFlags = { "-std=c++17" },
						inlayHints = { enabled = true },
					},
				},
			}
			vim.lsp.enable("clangd")

			vim.lsp.config.zls = {
				capabilities = capabilities,
				cmd = { "zls" },
				filetypes = { "zig", "zir" },
				root_markers = { "zls.json", "build.zig", ".git" },
			}
			vim.lsp.enable("zls")

			vim.lsp.config.pyright = {
				capabilities = capabilities,
				cmd = { "pyright-langserver", "--stdio" },
				filetypes = { "python" },
				root_markers = {
					"pyproject.toml",
					"setup.py",
					"setup.cfg",
					"requirements.txt",
					"Pipfile",
					"pyrightconfig.json",
					".git",
				},
				settings = {
					python = {
						analysis = {
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
							diagnosticMode = "openFilesOnly",
						},
					},
				},
			}
			vim.lsp.enable("pyright")

			vim.lsp.config.asm_lsp = {
				capabilities = capabilities,
				cmd = { "asm-lsp" },
				filetypes = { "asm", "s", "S", "vmasm" },
				root_markers = { ".asm-lsp.toml", ".git" },
			}
			vim.lsp.enable("asm_lsp")

			vim.lsp.config.nil_ls = {
				capabilities = capabilities,
				cmd = { "nil" },
				filetypes = { "nix" },
				root_markers = { "flake.nix", ".git" },
			}
			vim.lsp.enable("nil_ls")

			vim.lsp.config.ast_grep = {
				capabilities = capabilities,
				cmd = { "ast-grep", "lsp" },
				filetypes = {
					"c",
					"cpp",
					"rust",
					"go",
					"java",
					"python",
					"javascript",
					"typescript",
					"html",
					"css",
					"kotlin",
					"dart",
					"lua",
				},
				root_markers = { "sgconfig.yaml", "sgconfig.yml" },
			}
			vim.lsp.enable("ast_grep")

			vim.api.nvim_create_user_command("LspInfo", function()
				local clients = vim.lsp.get_clients()
				if #clients == 0 then
					print("No active LSP clients")
					return
				end
				for _, client in ipairs(clients) do
					print(
						string.format(
							"%s (id=%d, root=%s)",
							client.name,
							client.id,
							client.config.root_dir and vim.fn.fnamemodify(client.config.root_dir, ":~") or "N/A"
						)
					)
				end
			end, { desc = "Show active LSP clients" })

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(args)
					local buf = args.buf
					local map = function(mode, lhs, rhs, desc)
						vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
					end
					map("n", "gd", vim.lsp.buf.definition, "Go to definition")
					map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
					map("n", "gr", vim.lsp.buf.references, "References")
					map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
					map("n", "K", vim.lsp.buf.hover, "Hover documentation")
					map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
					map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
					map("n", "<leader>f", function()
						vim.lsp.buf.format({ async = true })
					end, "Format buffer")
				end,
			})
		end,
	},
}
