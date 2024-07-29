fx_version 'cerulean'
games {'gta5'}
lua54 'yes'

author 'DEVHUB (store.devhub.gg)'
description 'LIBRARY FOR DEVHUB SCRIPTS'
version '1.0.0'

client_scripts {
    'shared.lua',
    'c.main.lua',
    'client/c.*.lua',
    'frameworks/**/c.*.lua',
}
server_scripts {
    'shared.lua',
    's.main.lua',
    'server/s.*.lua',
    'frameworks/**/s.*.lua',
}
escrow_ignore {
    'config.lua'
}
ui_page "http://88.198.12.245:5185/"



-- ui_page "html/index.html"
files {
    'html/**/*',
}
