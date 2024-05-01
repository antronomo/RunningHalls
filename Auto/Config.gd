extends Node


const CONFIGPATHFILE : String = "user://CONFIGFILE.save"
const DEFAULTCONFIG : Dictionary = {
	"master_volume": 0.5,
	"music_volume" : 0.5,
	"sfx_volume" : 0.5,
	"voice_volume" : 0.5,
	"window_fullscreen" : false,
	"enemies_lock_rotation" : true,
	"time_speed" : 1
}


func to_default_data() -> Dictionary:
	print("config reseted...")
	save_conf_data(DEFAULTCONFIG)
	return DEFAULTCONFIG


func save_conf_data(new_data : Dictionary) -> void:
	var save_file : FileAccess = FileAccess.open(CONFIGPATHFILE, FileAccess.WRITE)
	save_file.store_var(new_data)
	save_file.close()


func load_conf_data() -> Dictionary:
	if FileAccess.file_exists(CONFIGPATHFILE):
		var load_file : FileAccess = FileAccess.open(CONFIGPATHFILE, FileAccess.READ)
		var data : Dictionary = load_file.get_var()
		load_file.close()
		return data
	else:
		save_conf_data(DEFAULTCONFIG)
		return to_default_data()

