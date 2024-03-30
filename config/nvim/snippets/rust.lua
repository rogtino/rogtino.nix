return {
	s(
		"afn",
		fmt(
			[[
         async fn {}()->{}{{
            {}
         }}
         ]],
			ins_generate()
		)
	),
	s(
		"str",
		fmt(
			[[
            struct {}{{
                {}
            }}

         ]],
			ins_generate()
		)
	),
	s(
		"pstr",
		fmt(
			[[
            pub struct {}{{
                {}
            }}

         ]],
			ins_generate()
		)
	),
	s(
		"pfn",
		fmt(
			[[
         pub fn {}({})->{}{{
            {}
         }}
         ]],
			ins_generate()
		)
	),
	s(
		"pafn",
		fmt(
			[[
         pub async fn {}()->{}{{
            {}
         }}
         ]],
			ins_generate()
		)
	),
	s(
		"modtest",
		fmt(
			[[
            #[cfg(test)]
            mod tests{{
                use super::*;
                #[test]
                fn {}(){{
                    {}
                }}
            }}
         ]],
			ins_generate()
		)
	),
	s(
		"amain",
		fmt(
			[[
            async fn main(){}{{
                {}
            }}
         ]],
			ins_generate()
		)
	),
	s(
		"main",
		fmt(
			[[
            fn main(){}{{
                {}
            }}
         ]],
			ins_generate()
		)
	),
	s(
		"test",
		fmt(
			[[
            #[test]
            fn {}(){{
                {}
            }}
         ]],
			ins_generate()
		)
	),

	s(
		"ilet",
		fmt(
			[[
if let {} = {} {{
    {}
}}
         ]],
			{ i(2), i(1), i(3) }
		)
	),
}
