return {
	s(
		"ust",
		fmt("const [{},{}] = useState({})", {
			i(1),
			f(function(args)
				local str = args[1][1]
				return "set" .. str:sub(1, 1):upper() .. str:sub(2)
			end, { 1 }),
			i(2),
		})
	),
	s(
		"imf",
		fmt("import {{{}}} from '{}'", {
			-- c(2, { f(function(param)
			--     return "{" .. param[1][1] .. "}"
			-- end, { 1 }), t "" }),
			i(1),
			i(2),
		})
	),
	s(
		"edf",
		fmt(
			[[
import React from "react";

const {}: React.FC<{}> = ({}) => {{
  return {};
}};

export default {};
]],
			{
				d(1, function(_, snip)
					local path = snip.env.TM_FILENAME
					local name = string.match(path, "(%a+).tsx")
					---@diagnostic disable-next-line: param-type-mismatch
					name = name:sub(1, 1):upper() .. name:sub(2)
					return sn(nil, {
						i(1, name),
					})
				end, {}),
				i(2, "null"),
				i(3),
				d(3, function(_, snip)
					local path = snip.env.TM_FILENAME
					local name = string.match(path, "(%a+).tsx")
					---@diagnostic disable-next-line: param-type-mismatch
					name = name:sub(1, 1):upper() .. name:sub(2)
					return sn(nil, {
						i(1, "<div>" .. name .. "</div>"),
					})
				end, {}),
				rep(1),
			}
		)
	),
	s("arr", fmt("({}) => {{{}}}", { i(1), i(2) })),
	s("clo", fmt("console.log({})", { i(1) })),
	s("div", fmt("<div className='{}'>{}</div>", { i(1), i(2) })),
	s("h1", fmt("<h1 className='{}'>{}</h1>", { i(1), i(2) })),
	s("h2", fmt("<h2 className='{}'>{}</h2>", { i(1), i(2) })),
	s("h3", fmt("<h3 className='{}'>{}</h3>", { i(1), i(2) })),
	s("p", fmt("<p className='{}'>{}</p>", { i(1), i(2) })),
	s("span", fmt("<span className='{}'>{}</span>", { i(1), i(2) })),
	s("header", fmt("<header className='{}'>{}</header>", { i(1), i(2) })),
	s(
		"car",
		fmt(
			[[
  const {} = ({}) => {{
    {}
  }}
  ]],
			{ i(1), i(2), i(3) }
		)
	),
}
