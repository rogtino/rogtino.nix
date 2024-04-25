return {
    name = 'xmake',
    builder = function()
        local cmd = { 'xmake', 'run' }
        return {
            cmd = cmd,
            components = {
                { 'on_output_quickfix', set_diagnostics = true },
                'on_result_diagnostics',
                'default',
            },
        }
    end,
    condition = {
        filetype = { 'cpp', 'c' },
    },
}
