#!/usr/bin/env bash
nix-locate 'lib/libsqlite3.so' | grep sqlite.out | awk '{print $4}' | head -n 1 >~/.config/nvim/sqlite3.path
