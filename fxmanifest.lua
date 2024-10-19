fx_version 'cerulean'
games {'gta5'}
lua54 'yes'

author 'DEVHUB (store.devhub.gg)'
description 'LIBRARY FOR DEVHUB SCRIPTS'
version '1.0.3'

client_scripts {
    -- '@vrp/lib/utils.lua',
    'shared.lua',
    'sh.autoDetect.lua',
    'c.main.lua',
    'client/c.*.lua',
    'tests/c.*.lua',
    'tests/functions/c.*.lua',
    'frameworks/**/c.*.lua',
}

server_scripts {
    -- '@vrp/lib/utils.lua',
    '@oxmysql/lib/MySQL.lua',
    'shared.lua',
    'sh.autoDetect.lua',
    's.main.lua',
    'server/s.*.lua',
    'tests/s.*.lua',
    'tests/functions/s.*.lua',
    'frameworks/**/s.*.lua',
}

shared_scripts {
    'shared/sh.*.lua',
}

ui_page "html/index.html"

files {
    'html/**/*',
}