#!/usr/bin/env bash
nix-locate 'lib/libsqlite3.so' | grep sqlite.out | awk '{print $4}' | head -n 1 >sqlite3.path
