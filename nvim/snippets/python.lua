-- Custom Python snippets (LuaSnip lua format)
local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

return {
	s(
		{ trig = "main", desc = 'if __name__ == "__main__"' },
		fmt(
			[[
			def main() -> None:
			    {}


			if __name__ == "__main__":
			    main()
			]],
			{ i(1, "pass") }
		)
	),

	s(
		{ trig = "def", desc = "function definition" },
		fmt(
			[[
			def {}({}) -> {}:
			    {}
			]],
			{ i(1, "name"), i(2), i(3, "None"), i(4, "pass") }
		)
	),

	s(
		{ trig = "defm", desc = "method definition" },
		fmt(
			[[
			def {}(self{}) -> {}:
			    {}
			]],
			{ i(1, "name"), i(2), i(3, "None"), i(4, "pass") }
		)
	),

	s(
		{ trig = "adef", desc = "async function definition" },
		fmt(
			[[
			async def {}({}) -> {}:
			    {}
			]],
			{ i(1, "name"), i(2), i(3, "None"), i(4, "pass") }
		)
	),

	s(
		{ trig = "class", desc = "class definition" },
		fmt(
			[[
			class {}:
			    def __init__(self{}) -> None:
			        {}
			]],
			{ i(1, "Name"), i(2), i(3, "pass") }
		)
	),

	s(
		{ trig = "dclass", desc = "dataclass definition" },
		fmt(
			[[
			@dataclass
			class {}:
			    {}
			]],
			{ i(1, "Name"), i(2, "pass") }
		)
	),

	s(
		{ trig = "for", desc = "for loop" },
		fmt(
			[[
			for {} in {}:
			    {}
			]],
			{ i(1, "item"), i(2, "items"), i(3, "pass") }
		)
	),

	s(
		{ trig = "fore", desc = "for loop with enumerate" },
		fmt(
			[[
			for {}, {} in enumerate({}):
			    {}
			]],
			{ i(1, "idx"), i(2, "item"), i(3, "items"), i(4, "pass") }
		)
	),

	s(
		{ trig = "forr", desc = "for loop over range" },
		fmt(
			[[
			for {} in range({}):
			    {}
			]],
			{ i(1, "i"), i(2, "n"), i(3, "pass") }
		)
	),

	s(
		{ trig = "while", desc = "while loop" },
		fmt(
			[[
			while {}:
			    {}
			]],
			{ i(1, "condition"), i(2, "pass") }
		)
	),

	s(
		{ trig = "if", desc = "if statement" },
		fmt(
			[[
			if {}:
			    {}
			]],
			{ i(1, "condition"), i(2, "pass") }
		)
	),

	s(
		{ trig = "ifel", desc = "if/else statement" },
		fmt(
			[[
			if {}:
			    {}
			else:
			    {}
			]],
			{ i(1, "condition"), i(2, "pass"), i(3, "pass") }
		)
	),

	s(
		{ trig = "tryex", desc = "try/except block" },
		fmt(
			[[
			try:
			    {}
			except {} as {}:
			    {}
			]],
			{ i(1, "pass"), i(2, "Exception"), i(3, "e"), i(4, "pass") }
		)
	),

	s(
		{ trig = "with", desc = "with statement" },
		fmt(
			[[
			with {} as {}:
			    {}
			]],
			{ i(1, 'open("file")'), i(2, "f"), i(3, "pass") }
		)
	),

	s(
		{ trig = "lam", desc = "lambda expression" },
		fmt("{} = lambda {}: {}", { i(1, "fn"), i(2, "x"), i(3) })
	),

	s(
		{ trig = "dc", desc = "docstring" },
		fmt(
			[[
			"""{}

			Args:
			    {}

			Returns:
			    {}
			"""
			]],
			{ i(1, "Summary."), i(2), i(3) }
		)
	),

	s(
		{ trig = "imp", desc = "import" },
		fmt("import {}", { i(1, "module") })
	),

	s(
		{ trig = "fromimp", desc = "from ... import" },
		fmt("from {} import {}", { i(1, "module"), i(2, "name") })
	),

	s(
		{ trig = "pr", desc = "print f-string" },
		fmt('print(f"{}")', { i(1) })
	),
}
