-- Custom C snippets (LuaSnip lua format)
local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

return {
	s(
		{ trig = "main", desc = "main function" },
		fmt(
			[=[
			int main(int argc, char *argv[])
			{{
				{}
				return 0;
			}}
			]=],
			{ i(1) }
		)
	),

	s(
		{ trig = "inc", desc = "#include <>" },
		fmt('#include <{}>', { i(1, "stdio.h") })
	),

	s(
		{ trig = "incs", desc = '#include ""' },
		fmt('#include "{}"', { i(1, "header.h") })
	),

	s(
		{ trig = "def", desc = "#define" },
		fmt("#define {} {}", { i(1, "NAME"), i(2, "value") })
	),

	s(
		{ trig = "guard", desc = "include guard" },
		fmt(
			[[
			#ifndef {}
			#define {}

			{}

			#endif /* {} */
			]],
			{ i(1, "HEADER_H"), rep(1), i(2), rep(1) }
		)
	),

	s(
		{ trig = "for", desc = "for loop" },
		fmt(
			[[
			for ({} {} = {}; {} < {}; {}++) {{
				{}
			}}
			]],
			{ i(1, "int"), i(2, "i"), i(3, "0"), rep(2), i(4, "n"), rep(2), i(5) }
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
		{ trig = "dowhile", desc = "do while loop" },
		fmt(
			[[
			do {{
				{}
			}} while ({});
			]],
			{ i(2), i(1, "condition") }
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
		{ trig = "switch", desc = "switch statement" },
		fmt(
			[[
			switch ({}) {{
			case {}:
				{}
				break;
			default:
				{}
				break;
			}}
			]],
			{ i(1, "value"), i(2, "0"), i(3), i(4) }
		)
	),

	s(
		{ trig = "struct", desc = "struct definition" },
		fmt(
			[[
			struct {} {{
				{}
			}};
			]],
			{ i(1, "name"), i(2) }
		)
	),

	s(
		{ trig = "tds", desc = "typedef struct" },
		fmt(
			[[
			typedef struct {} {{
				{}
			}} {};
			]],
			{ i(1, "name"), i(2), rep(1) }
		)
	),

	s(
		{ trig = "enum", desc = "enum definition" },
		fmt(
			[[
			enum {} {{
				{}
			}};
			]],
			{ i(1, "name"), i(2) }
		)
	),

	s(
		{ trig = "fn", desc = "function definition" },
		fmt(
			[[
			{} {}({})
			{{
				{}
			}}
			]],
			{ i(1, "void"), i(2, "name"), i(3), i(4) }
		)
	),

	s(
		{ trig = "pr", desc = "printf" },
		fmt('printf("{}\\n"{});', { i(1, "%s"), i(2) })
	),

	s(
		{ trig = "malloc", desc = "malloc with cast and check" },
		fmt(
			[[
			{} *{} = malloc({} * sizeof({}));
			if ({} == NULL) {{
				{}
			}}
			]],
			{ i(1, "int"), i(2, "ptr"), i(3, "n"), rep(1), rep(2), i(4, "return 1;") }
		)
	),
}
