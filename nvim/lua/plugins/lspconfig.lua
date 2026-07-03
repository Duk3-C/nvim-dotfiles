return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end
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
        },
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.lsp.config.lua_ls = {
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

      vim.api.nvim_create_user_command("LspInfo", function()
        local clients = vim.lsp.get_clients()
        if #clients == 0 then
          print("No active LSP clients")
          return
        end
        for _, client in ipairs(clients) do
          print(string.format("%s (id=%d, root=%s)", client.name, client.id, client.config.root_dir and vim.fn.fnamemodify(client.config.root_dir, ":~") or "N/A"))
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
