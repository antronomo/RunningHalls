extends ParallaxBackground


onready var sewer : PackedScene = preload("res://resources/inSewerParallaxBackground.tscn")
onready var cave : PackedScene = preload("res://resources/inCaveParallaxBackground.tscn")

onready var backgrounds : Array = [
	sewer,
	cave
]


func set_background() -> void:
	add_child(backgrounds[randi() % backgrounds.size()].instance())