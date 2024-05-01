extends CoreComponent


@onready var body : Enemy = get_node("../") 


var wave_multiplier : float = 0.1
var boss_multiplier : float = 2.0
var current_wave : int = 0


func _ready() -> void:
	connect("body_entered", Callable(self, "_on_EnemyStats_body_entered" ))
	
	current_wave = clamp(Globals.saved_wave, 0 , 150)
	
	# print(str(current_wave))
	wave_buff()
	super()


func print_stats() -> void:
	print(JSON.stringify(get_stats(), "\t"))


func wave_buff() -> void:
	set_max_hp(max_life + max_life * (current_wave * wave_multiplier))
	attack += attack * (current_wave * wave_multiplier)
	defense += defense * (current_wave * wave_multiplier)
	# critical_chance += critical_chance * (current_wave * 0.01)
	# critical_damage += critical_damage * (current_wave * 0.01)

	# print_stats()


func boss_buff() -> void:
	set_max_hp(max_life * boss_multiplier)
	attack *= boss_multiplier
	defense *= boss_multiplier
	# critical_chance *= boss_multiplier
	# critical_damage *= boss_multiplier

	# print_stats()


func _on_CoreComponent_area_entered(area : CoreComponent) -> void:
	super(area)
	body.knock_back()


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
