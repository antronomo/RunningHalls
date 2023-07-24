extends Control


onready var health_bar : TextureProgress = $MarginContainer/HealthBar
onready var health_label : Label = $MarginContainer/Label


func first_call(maxHP : int) -> void:
	health_bar.max_value = maxHP
	health_bar.value = maxHP

	health_label.text = str(maxHP)


func update_helath_bar(newHP : int) -> void : 
	health_bar.value = newHP
	health_label.text = str(newHP)


"""
He perdido como 30 minutos porque no podía llamar la función 'first_call', 
resulta que no asigné el script a la escena GUI.tscn jajaja
"""
