fx_version 'adamant'
game 'gta5'

lua54 'yes'
shared_script {'@es_extended/imports.lua','@ox_lib/init.lua'}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'npcprodaja-sv.lua',

}

client_scripts {
	'@es_extended/locale.lua',
	'npcprodaja.lua',
}

