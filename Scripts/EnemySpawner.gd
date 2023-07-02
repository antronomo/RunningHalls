extends Position2D


# Hay alguna manera de añadir al array 'enemies' todos los nodods de la carpeta 'Enemies'?
var packedWizard : PackedScene = preload("res://enemies/DarkWizard.tscn")
var packedHumacean : PackedScene = preload("res://enemies/Humacean.tscn")


var enemies : Array = [
	packedWizard,
	packedHumacean
]


func spawn_new_enemy() -> void:
	var num = randi() % enemies.size()
	var newEnemy = enemies[num].instance()
	add_child(newEnemy)
