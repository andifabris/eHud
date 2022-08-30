fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Evolution Software Inc'
contact 'Website: www.evolutionfivem.com - E-mail: contato@evolutionfivem.com - Discord: discord.gg/evolutionfivem'

ui_page 'web/darkside.html'

client_scripts {
	'@vrp/lib/utils.lua',
	'config/*',
	'client/*'
}

server_scripts {
	'@vrp/lib/utils.lua',
	'config/*',
	'server/*'
}

files {
    'web/*',
	'web/**/*'
}

escrow_ignore {
	'config/*',
}