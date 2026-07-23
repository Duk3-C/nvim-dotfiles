-- Custom Nix snippets (LuaSnip lua format)
local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

return {
	s(
		{ trig = "flake", desc = "flake.nix skeleton" },
		fmt(
			[[
			{{
			  description = "{}";

			  inputs = {{
			    nixpkgs.url = "github:NixOS/nixpkgs/{}";
			  }};

			  outputs = {{ self, nixpkgs, ... }}: {{
			    {}
			  }};
			}}
			]],
			{ i(1, "A very basic flake"), i(2, "nixos-unstable"), i(3) }
		)
	),

	s(
		{ trig = "shell", desc = "shell.nix with mkShell" },
		fmt(
			[[
			{{ pkgs ? import <nixpkgs> {{ }} }}:

			pkgs.mkShell {{
			  packages = with pkgs; [
			    {}
			  ];
			}}
			]],
			{ i(1) }
		)
	),

	s(
		{ trig = "devshell", desc = "flake devShell output" },
		fmt(
			[[
			devShells.{}.default = pkgs.mkShell {{
			  packages = with pkgs; [
			    {}
			  ];
			}};
			]],
			{ i(1, "x86_64-linux"), i(2) }
		)
	),

	s(
		{ trig = "drv", desc = "stdenv.mkDerivation" },
		fmt(
			[[
			stdenv.mkDerivation {{
			  pname = "{}";
			  version = "{}";

			  src = {};

			  buildInputs = [ {} ];

			  {}
			}}
			]],
			{ i(1, "name"), i(2, "0.1.0"), i(3, "./."), i(4), i(5) }
		)
	),

	s(
		{ trig = "fetchgh", desc = "fetchFromGitHub" },
		fmt(
			[[
			fetchFromGitHub {{
			  owner = "{}";
			  repo = "{}";
			  rev = "{}";
			  hash = "{}";
			}}
			]],
			{ i(1, "owner"), i(2, "repo"), i(3, "v1.0.0"), i(4, "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=") }
		)
	),

	s(
		{ trig = "let", desc = "let ... in expression" },
		fmt(
			[[
			let
			  {} = {};
			in
			  {}
			]],
			{ i(1, "name"), i(2, "value"), i(3) }
		)
	),

	s(
		{ trig = "fn", desc = "function with attrset pattern" },
		fmt(
			[[
			{{ {} }}:

			{}
			]],
			{ i(1, "pkgs, lib, ..."), i(2) }
		)
	),

	s(
		{ trig = "if", desc = "if/then/else expression" },
		fmt("if {} then {} else {}", { i(1, "condition"), i(2, "true"), i(3, "false") })
	),

	s(
		{ trig = "with", desc = "with expression" },
		fmt("with {}; {}", { i(1, "pkgs"), i(2) })
	),

	s(
		{ trig = "inherit", desc = "inherit statement" },
		fmt("inherit ({}) {};", { i(1, "pkgs"), i(2, "name") })
	),

	s(
		{ trig = "attr", desc = "attribute set" },
		fmt(
			[[
			{} = {{
			  {}
			}};
			]],
			{ i(1, "name"), i(2) }
		)
	),

	s(
		{ trig = "opt", desc = "module option (mkOption)" },
		fmt(
			[[
			{} = lib.mkOption {{
			  type = lib.types.{};
			  default = {};
			  description = "{}";
			}};
			]],
			{ i(1, "name"), i(2, "bool"), i(3, "false"), i(4) }
		)
	),

	s(
		{ trig = "module", desc = "NixOS module skeleton" },
		fmt(
			[[
			{{ config, lib, pkgs, ... }}:

			let
			  cfg = config.{};
			in
			{{
			  options.{} = {{
			    enable = lib.mkEnableOption "{}";
			  }};

			  config = lib.mkIf cfg.enable {{
			    {}
			  }};
			}}
			]],
			{ i(1, "services.myservice"), rep(1), i(2, "my service"), i(3) }
		)
	),

	s(
		{ trig = "overlay", desc = "overlay function" },
		fmt(
			[[
			final: prev: {{
			  {} = {};
			}}
			]],
			{ i(1, "package"), i(2) }
		)
	),

	s(
		{ trig = "map", desc = "map over list" },
		fmt("map ({}: {}) {}", { i(1, "x"), i(2), i(3, "list") })
	),
}
