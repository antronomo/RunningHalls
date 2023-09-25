extends Node


const CONFIGFILE : String = "user://CONFIGFILE.save"
const DefaultConfig : Dictionary = {
	"master_volume": 0.5,
	"music_volume" : 0.5,
	"sfx_volume" : 0.5,
	"window_fullscreen" : false,
}


var config_data : Dictionary = {}


func load_data() -> void:
	var load_file : File = File.new()

	if !load_file.file_exists(CONFIGFILE):
		to_default_data()
		
	load_file.open(CONFIGFILE, File.READ)
	config_data = load_file.get_var()
		
	load_file.close()


func save_data() -> void:
	var save_file : File = File.new()
	save_file.open(CONFIGFILE, File.WRITE)
	save_file.store_var(config_data)
	save_file.close()


func to_default_data() -> void:
	config_data = DefaultConfig.duplicate()
	save_data()
