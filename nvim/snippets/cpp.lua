-- Custom C++ snippets (LuaSnip lua format)
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
		fmt("#include <{}>", { i(1, "iostream") })
	),

	s(
		{ trig = "incs", desc = '#include ""' },
		fmt('#include "{}"', { i(1, "header.hpp") })
	),

	s(
		{ trig = "class", desc = "class with constructor/destructor" },
		fmt(
			[[
			class {} {{
			public:
				{}();
				~{}();

				{}

			private:
				{}
			}};
			]],
			{ i(1, "Name"), rep(1), rep(1), i(2), i(3) }
		)
	),

	s(
		{ trig = "ns", desc = "namespace" },
		fmt(
			[[
			namespace {} {{

			{}

			}} // namespace {}
			]],
			{ i(1, "name"), i(2), rep(1) }
		)
	),

	s(
		{ trig = "cout", desc = "std::cout" },
		fmt("std::cout << {} << '\\n';", { i(1) })
	),

	s(
		{ trig = "cin", desc = "std::cin" },
		fmt("std::cin >> {};", { i(1) })
	),

	s(
		{ trig = "vec", desc = "std::vector" },
		fmt("std::vector<{}> {}{};", { i(1, "int"), i(2, "v"), i(3) })
	),

	s(
		{ trig = "map", desc = "std::unordered_map" },
		fmt("std::unordered_map<{}, {}> {};", { i(1, "std::string"), i(2, "int"), i(3, "m") })
	),

	s(
		{ trig = "uptr", desc = "std::unique_ptr" },
		fmt("auto {} = std::make_unique<{}>({});", { i(1, "ptr"), i(2, "T"), i(3) })
	),

	s(
		{ trig = "sptr", desc = "std::shared_ptr" },
		fmt("auto {} = std::make_shared<{}>({});", { i(1, "ptr"), i(2, "T"), i(3) })
	),

	s(
		{ trig = "tryc", desc = "try/catch block" },
		fmt(
			[[
			try {{
				{}
			}} catch ({} &{}) {{
				{}
			}}
			]],
			{ i(1), i(2, "const std::exception"), i(3, "e"), i(4) }
		)
	),

	s(
		{ trig = "tmpl", desc = "template function" },
		fmt(
			[[
			template <typename {}>
			{} {}({})
			{{
				{}
			}}
			]],
			{ i(1, "T"), i(2, "void"), i(3, "name"), i(4), i(5) }
		)
	),

	s(
		{ trig = "forr", desc = "range-based for loop" },
		fmt(
			[[
			for (const auto &{} : {}) {{
				{}
			}}
			]],
			{ i(1, "item"), i(2, "container"), i(3) }
		)
	),

	s(
		{ trig = "for", desc = "for loop" },
		fmt(
			[[
			for ({} {} = {}; {} < {}; ++{}) {{
				{}
			}}
			]],
			{ i(1, "int"), i(2, "i"), i(3, "0"), rep(2), i(4, "n"), rep(2), i(5) }
		)
	),

	s(
		{ trig = "lambda", desc = "lambda expression" },
		fmt("auto {} = [{}]({}) {{ {} }};", { i(1, "fn"), i(2), i(3), i(4) })
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
		{ trig = "struct", desc = "struct definition" },
		fmt(
			[[
			struct {} {{
				{}
			}};
			]],
			{ i(1, "Name"), i(2) }
		)
	),
}
