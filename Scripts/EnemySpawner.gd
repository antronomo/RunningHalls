extends Position2D


# Hay alguna manera de añadir al array 'enemies' todos los nodods de la carpeta 'Enemies'?
var packed_Wizard : PackedScene = preload("res://enemies/DarkWizard.tscn")
var packed_Humacean : PackedScene = preload("res://enemies/Humacean.tscn")
var packed_ghost : PackedScene = preload("res://Enemies/Ghost.tscn")


var enemies : Array = [
	packed_Wizard,
	packed_Humacean,
	packed_ghost
]


func spawn_new_enemy() -> void:
	var num = randi() % enemies.size()
	var newEnemy = enemies[num].instance()
	add_child(newEnemy)
