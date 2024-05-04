return {
  s(
    'unm',
    fmt(
      [[
      using namespace {};
      {}
	]],
      ins_generate()
    )
  ),
  s(
    'for',
    fmt(
      [[
        for(auto {};{};{}){{
            {0}
        }}
	]],
      ins_generate()
    )
  ),
  s(
    'if',
    fmt(
      [[
      if ({}) {{
        {}
      }} {}
	]],
      ins_generate()
    )
  ),
  s(
    'ifi',
    fmt(
      [[
      if ({}; {}) {{
        {}
      }} {}
	]],
      ins_generate()
    )
  ),
}
