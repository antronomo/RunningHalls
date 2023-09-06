extends Node


const SAVEFILE = "user://SAVEFILE.save"
const CurrentVersion = "0.0.1"
const DefaultGameData : Dictionary = {
    "wave" : 0,
	"player_upgrades" : {
		"life" : 0,
		"attack" : 0,
		"deffense" : 0,
		"crit_chance" : 0,
		"crit_dmg" : 0
	},
	"artifacts" : {
		"solt_1" : "",
		"solt_2" : "",
		"solt_3" : ""
	},
	"game_version" : CurrentVersion
}


var game_data : Dictionary = {}
var wave : int = 0


func _ready() -> void:	
	load_data()


func load_data() -> void:
	var load_file = File.new()

	if !load_file.file_exists(SAVEFILE):
		to_default_data()
		
	load_file.open(SAVEFILE, File.READ)
	game_data = load_file.get_var()
	
	# if !game_data.has("version") || game_data.version != CurrentVersion:
	# 	to_default_data()
		
	load_file.close()


func save_data() -> void:
	var save_file = File.new()
	save_file.open(SAVEFILE, File.WRITE)
	save_file.store_var(game_data)
	save_file.close()


func to_default_data() -> void:
	game_data = DefaultGameData.duplicate()
	save_data()