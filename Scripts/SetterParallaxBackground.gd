extends ParallaxBackground


# Aquí si me interesa tener variables por si quiero dar la opcion al jugador de elegir el fondo o escenario
@onready var sewer : PackedScene = preload("res://BackGrounds/inSewerParallaxBackground.tscn")
@onready var cave : PackedScene = preload("res://BackGrounds/inCaveParallaxBackground.tscn")


@onready var backgrounds : Array = [
	sewer,
	cave
]


func set_background() -> void:
	add_child(backgrounds[randi() % backgrounds.size()].instantiate())
