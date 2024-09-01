fx_version 'cerulean'
games {'gta5'}
lua54 'yes'

author 'DEVHUB (store.devhub.gg)'
description 'LIBRARY FOR DEVHUB SCRIPTS'
version '1.0.1'

client_scripts {
    'shared.lua',
    'c.main.lua',
    'client/c.*.lua',
    'frameworks/**/c.*.lua',
}
server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'shared.lua',
    's.main.lua',
    'server/s.*.lua',
    'frameworks/**/s.*.lua',
}

shared_scripts {
    'shared/sh.*.lua',
}

ui_page "html/index.html"

files {
    'html/**/*',
}