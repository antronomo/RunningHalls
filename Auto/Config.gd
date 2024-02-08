extends Node


const CONFIGPATHFILE : String = "user://CONFIGFILE.save"
const DEFAULTCONFIG : Dictionary = {
	"master_volume": 0.5,
	"music_volume" : 0.5,
	"sfx_volume" : 0.5,
	"window_fullscreen" : false,
}


func to_default_data() -> Dictionary:
	print("config reseted...")
	save_data(DEFAULTCONFIG.duplicate())
	return DEFAULTCONFIG


func save_data(new_data : Dictionary) -> void:
	var save_file : FileAccess = FileAccess.open(CONFIGPATHFILE, FileAccess.WRITE)
	save_file.store_var(new_data)
	save_file.close()


func load_data() -> Dictionary:
	if FileAccess.file_exists(CONFIGPATHFILE):
		var load_file : FileAccess = FileAccess.open(CONFIGPATHFILE, FileAccess.READ)
		var data : Dictionary = load_file.get_var()
		load_file.close()
		return data
	else:
		save_data(to_default_data().duplicate)
		return DEFAULTCONFIG

