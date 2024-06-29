#!/usr/bin/env nu
nix-locate 'lib/libsqlite3.so' | find sqlite.out | get 0 | split row -r '\s+' | get 3 | save -f ~/.config/nvim/sqlite3.path
