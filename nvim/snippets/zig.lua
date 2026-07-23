-- Custom Zig snippets (LuaSnip lua format)
local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

return {
	s(
		{ trig = "main", desc = "pub fn main" },
		fmt(
			[[
			const std = @import("std");

			pub fn main() !void {{
				{}
			}}
			]],
			{ i(1) }
		)
	),

	s(
		{ trig = "imp", desc = "@import" },
		fmt('const {} = @import("{}");', { i(1, "std"), rep(1) })
	),

	s(
		{ trig = "fn", desc = "function definition" },
		fmt(
			[[
			fn {}({}) {} {{
				{}
			}}
			]],
			{ i(1, "name"), i(2), i(3, "void"), i(4) }
		)
	),

	s(
		{ trig = "pfn", desc = "public function definition" },
		fmt(
			[[
			pub fn {}({}) {} {{
				{}
			}}
			]],
			{ i(1, "name"), i(2), i(3, "void"), i(4) }
		)
	),

	s(
		{ trig = "test", desc = "test block" },
		fmt(
			[[
			test "{}" {{
				{}
			}}
			]],
			{ i(1, "description"), i(2) }
		)
	),

	s(
		{ trig = "struct", desc = "struct definition" },
		fmt(
			[[
			const {} = struct {{
				{}
			}};
			]],
			{ i(1, "Name"), i(2) }
		)
	),

	s(
		{ trig = "enum", desc = "enum definition" },
		fmt(
			[[
			const {} = enum {{
				{}
			}};
			]],
			{ i(1, "Name"), i(2) }
		)
	),

	s(
		{ trig = "union", desc = "tagged union definition" },
		fmt(
			[[
			const {} = union(enum) {{
				{}
			}};
			]],
			{ i(1, "Name"), i(2) }
		)
	),

	s(
		{ trig = "if", desc = "if statement" },
		fmt(
			[[
			if ({}) {{
				{}
			}}
			]],
			{ i(1, "condition"), i(2) }
		)
	),

	s(
		{ trig = "ifel", desc = "if/else statement" },
		fmt(
			[[
			if ({}) {{
				{}
			}} else {{
				{}
			}}
			]],
			{ i(1, "condition"), i(2), i(3) }
		)
	),

	s(
		{ trig = "for", desc = "for loop" },
		fmt(
			[[
			for ({}) |{}| {{
				{}
			}}
			]],
			{ i(1, "items"), i(2, "item"), i(3) }
		)
	),

	s(
		{ trig = "fori", desc = "for loop with index" },
		fmt(
			[[
			for ({}, 0..) |{}, {}| {{
				{}
			}}
			]],
			{ i(1, "items"), i(2, "item"), i(3, "idx"), i(4) }
		)
	),

	s(
		{ trig = "while", desc = "while loop" },
		fmt(
			[[
			while ({}) {{
				{}
			}}
			]],
			{ i(1, "condition"), i(2) }
		)
	),

	s(
		{ trig = "switch", desc = "switch statement" },
		fmt(
			[[
			switch ({}) {{
				{} => {},
				else => {},
			}}
			]],
			{ i(1, "value"), i(2, ".case"), i(3, "{}"), i(4, "{}") }
		)
	),

	s(
		{ trig = "print", desc = "std.debug.print" },
		fmt('std.debug.print("{}\\n", .{{{}}});', { i(1, "{s}"), i(2) })
	),

	s(
		{ trig = "defer", desc = "defer statement" },
		fmt("defer {};", { i(1) })
	),

	s(
		{ trig = "errdefer", desc = "errdefer statement" },
		fmt("errdefer {};", { i(1) })
	),

	s(
		{ trig = "alloc", desc = "gpa allocator setup" },
		fmt(
			[[
			var gpa = std.heap.GeneralPurposeAllocator(.{{}}){{}};
			defer _ = gpa.deinit();
			const allocator = gpa.allocator();
			{}
			]],
			{ i(1) }
		)
	),

	s(
		{ trig = "catch", desc = "catch with capture" },
		fmt(
			[[
			{} catch |{}| {{
				{}
			}};
			]],
			{ i(1, "expr"), i(2, "err"), i(3) }
		)
	),
}
