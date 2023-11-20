extends Node


const SAVEFILE : String = "user://SAVEFILE.save"
const CurrentVersion : String = "0.0.1"
const DefaultGameData : Dictionary = {
	"game_info" : {
		"game_version" : CurrentVersion,
		"wave" : 1,
		"loot" : 0
	},
	"player_upgrades" : {
		"helmet" : 0,
		"chestPlate" :0,
		"greaves" : 0,
		"boots" :  0,
		"sword" :  0,
		"shield" : 0
	}
}


func new_game() -> Dictionary:
	print("new game")
	save_game_data(DefaultGameData)
	return DefaultGameData


func save_game_data(game_data : Dictionary) -> void:
	var save_file : File = File.new()
	save_file.open(SAVEFILE, File.WRITE)
	save_file.store_var(game_data)
	save_file.close()


func load_game() -> Dictionary:
	var load_file : File = File.new()
	
	if !load_file.file_exists(SAVEFILE):
		save_game_data(DefaultGameData.duplicate())
		return new_game()
	else:
		load_file.open(SAVEFILE, File.READ)
		var data : Dictionary = load_file.get_var()
		load_file.close()
		return data

