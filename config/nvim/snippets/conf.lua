return {
    s('tag', {
        t '#--',
        rep(2),
        t { '--#', '#  ' },
        i(1),
        t {
            '  #',
            '#--',
        },
        d(2, function(args)
            -- the returned snippetNode doesn't need a position; it's inserted
            -- "inside" the dynamicNode.
            return sn(nil, {
                -- jump-indices are local to each snippetNode, so restart at 1.
                i(1, string.rep('*', #args[1][1])),
                -- i(1,  tostring(#args[1][1])),
            })
        end, { 1 }),
        -- f( function(args)
        --     return string.rep("*",#args[1][1])
        -- end, { 1 }),
        t { '--#' },
    }),
}
