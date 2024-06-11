extends ParallaxBackground


# Aquí si me interesa tener variables por si quiero dar la opcion al jugador de elegir el fondo o escenario
@onready var forest : PackedScene = preload("res://BackGrounds/ForestParallaxBackground.tscn")
@onready var cave : PackedScene = preload("res://BackGrounds/inCaveParallaxBackground.tscn")
@onready var sewer : PackedScene = preload("res://BackGrounds/inSewerParallaxBackground.tscn")

# Escenas que usaré como entradas para transicioanr entre fondos
@onready var cave_entrance : PackedScene = preload("res://BackGrounds/CaveEntrance.tscn")
@onready var dungeon_entrance : PackedScene = preload("res://BackGrounds/DungeonEntrance.tscn")

@onready var current_wave : int = Globals.saved_wave


var parallax_speed : int : set = set_parallax_speed, get = get_parallax_speed 


func _ready() -> void:
	set_background()


func set_parallax_speed(new_speed : int) -> void:
	parallax_speed = new_speed
	for i in get_children(false):
		if i is CoreParallaxBackground:
			i.set_paraspeed(parallax_speed)


func get_parallax_speed() -> int:
	return parallax_speed


func set_background() -> void:
	if current_wave <= 33:
		add_child(forest.instantiate())
	elif current_wave <= 66:
		add_child(cave.instantiate())
	else:
		add_child(sewer.instantiate())


func set_transicion(next_bg : String) -> void:
	match next_bg:
		"forest":
			pass
		"cave":
			add_child(cave_entrance.instantiate())
			get_child(1).set_paraspeed(parallax_speed)
			await get_child(1).transitiontime
			add_child(cave.instantiate())
			set_parallax_speed(parallax_speed)
		"sewer":
			add_child(dungeon_entrance.instantiate())
			get_child(1).set_paraspeed(parallax_speed)
			await get_child(1).transitiontime
			add_child(sewer.instantiate())
			set_parallax_speed(parallax_speed)
		_:
			push_error("No background as " + next_bg)


func transition_time() -> void:
	get_child(0).queue_free()

