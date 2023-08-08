extends Position2D


# Hay alguna manera de añadir al array 'enemies' todos los nodods de la carpeta 'Enemies'?


var enemies : Array = [
	preload("res://enemies/DarkWizard.tscn"),
	preload("res://enemies/Humacean.tscn"),
	preload("res://Enemies/Ghost.tscn")
]


#Puedo evitar que ciertos enemigos aparezcan añadiendo otra variable en la primera línea
func spawn_new_enemy() -> void:
	var num = randi() % enemies.size() # -X para quitar los ultimos de la lista y +X para quitar los primeros
	var newEnemy = enemies[num].instance()
	add_child(newEnemy)
