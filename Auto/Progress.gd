extends Node


const ARCHIVEMENTSPATH : String = "user://PROGRESSFILE.save"
const PROGRESSLIST : Dictionary = {
	"ArchivementList" : {
		"trago bajo la lluvia" : false,
		"Final verdadero" : false,
	},
	"JewelList" : {
		"Crystal Heart" : true,
		"Mana Stone" : true, 
		"Spiky Gloves" : true,
	},
}


func new_jewelly() -> Dictionary:
	print("new progress")
	save_jewelly_data(PROGRESSLIST)
	return PROGRESSLIST


func save_jewelly_data(game_data : Dictionary) -> void:
	var save_file : FileAccess = FileAccess.open(ARCHIVEMENTSPATH, FileAccess.WRITE)
	save_file.store_var(game_data)
	save_file.close()


func load_jewelly() -> Dictionary:
	if FileAccess.file_exists(ARCHIVEMENTSPATH):
		var load_file : FileAccess = FileAccess.open(ARCHIVEMENTSPATH, FileAccess.READ)
		var data : Dictionary = load_file.get_var()
		load_file.close()
		return data
	else:
		save_jewelly_data(PROGRESSLIST)
		return new_jewelly()
		

"""
Este escript está destinado a ser el control del progreso del jugador fuera de las partidas, cosas como:
		-Artefactos desbloqueados
		-Logros
tal vez más cosas
"""
