return {
  "nvim-treesitter/nvim-treesitter", build = ":TSUpdate",
    opts = {
      ensure_installed = { "lua", "c", "html", "javascript", "python", "cpp", "rust", "zig" },
    autoinstall = true,
    highlight = { enable = true },
    indent = { enable = true },
  },
}
