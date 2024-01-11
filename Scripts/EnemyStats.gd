extends CoreComponent


onready var current_wave : int = Globals.current_game.game_info.wave


func _ready() -> void:
	max_life += max_life * (current_wave * 0.01)
	attack += attack * (current_wave * 0.01)
	defense += defense * (current_wave * 0.01)
	# critical_cahnce += critical_cahnce * (current_wave * 0.01)
	# critical_damage += critical_damage * (current_wave * 0.01)

	print_stats()


func print_stats() -> void:
	print(get_stats())


func boss_buff() -> void :
	max_life += max_life * 1.5
	attack += attack * 1.5
	defense += defense * 1.5
	# critical_cahnce += critical_cahnce * 1.5
	# critical_damage += critical_damage * 1.5

	print_stats()


"""
La idea de este escript es la de aumentar las estadísticas de los enemigos (de manera individual) dependiendo de cosas como:
	-la oleada actual de la partida
	-si es minijefe o jefe

creo que será algo como:
	var stats : Diccionary { estadisticas... }
	stats = stats + stats * oleada * 0.01
	se suma todo por (oleada * 0.01) en cada estat y ya, las estadísticas base de cada enemigo se modifican desde su escena

	y si es jefe todo multiplicado por 1.5 o 2 y ya
"""
