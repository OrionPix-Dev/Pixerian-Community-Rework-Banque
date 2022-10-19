fx_version('bodacious')
game('gta5')

lua54 'yes'

this_is_a_map 'yes'
loadscreen 'html/index.html'
loadscreen_manual_shutdown 'yes'

files({
	'html/index.html',
	'html/load.mp3',
	'html/css/app.css',
	'html/css/style.css',
	'html/js/app.js',
	'html/img/*.png',
	'html/fonts/*',
})


shared_scripts {
	'@es_extended/imports.lua',
	'shared/config.lua',
}
--UI
client_scripts {
	'UI/RageConfig.lua',
	'UI/RageUI.lua',
	'UI/Menu.lua',
	'UI/MenuController.lua',
	'UI/components/*.lua',
	'UI/elements/*.lua',
	'UI/items/*.lua',
}

client_scripts({
	'client/**'
})

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/**'
}