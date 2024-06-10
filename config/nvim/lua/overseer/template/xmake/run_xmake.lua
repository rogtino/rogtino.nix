return {
  name = 'run xmake',
  builder = function()
    return {
      cmd = { 'xmake' },
      args = { 'run' },
      components = {
        'default',
      },
    }
  end,
  condition = {
    filetype = { 'cpp', 'c' },
  },
}
