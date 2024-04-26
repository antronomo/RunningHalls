extends Node


const GAMEPATHFILE : String = "user://SAVEFILE.save"
const CURRENTVERSION : String = "0.25.1"
const DEFAULTGAMEDATA : Dictionary = {
	"game_info" : {
		"game_version" : CURRENTVERSION,
		"wave" : 1,
		"gold" : 0,
		"gains" : 0,
		"tries" : 0
	},
	"player_upgrades" : {
		"helmet" : 0,
		"chestPlate" : 0,
		"greaves" : 0,
		"boots" :  0,
		"sword" :  0,
		"shield" : 0
	}
}


func new_game() -> Dictionary:
	print("new game")
	save_game_data(DEFAULTGAMEDATA)
	return DEFAULTGAMEDATA


func save_game_data(game_data : Dictionary) -> void:
	var save_file : FileAccess = FileAccess.open(GAMEPATHFILE, FileAccess.WRITE)
	save_file.store_var(game_data)
	save_file.close()


func load_game() -> Dictionary:
	if FileAccess.file_exists(GAMEPATHFILE):
		var load_file : FileAccess = FileAccess.open(GAMEPATHFILE, FileAccess.READ)
		var data : Dictionary = load_file.get_var()
		load_file.close()
		return data
	else:
		save_game_data(DEFAULTGAMEDATA)
		return new_game()
		
