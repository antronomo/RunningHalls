extends Control


onready var health_bar : TextureProgress = $HealthBarContainer/HealthBar
onready var health_label : Label = $HealthBarContainer/Label
onready var coin_label : Label = $CurrencyContainer/Label


var loot : int = 0 setget set_loot, get_loot


func _ready() -> void:
	coin_label.text = str(loot)


func first_call(maxHP : int) -> void:
	health_bar.max_value = maxHP
	health_bar.value = maxHP

	health_label.text = str(maxHP)


func update_helath_bar(newHP : int) -> void : 
	health_bar.value = newHP
	health_label.text = str(newHP)


func set_loot(add_loot : int) -> void:
	loot += add_loot
	coin_label.text = str(loot)


func get_loot() -> int: 
	return loot


"""
He perdido como 30 minutos porque no podía llamar la función 'first_call', 
resulta que no asigné el script a la escena GUI.tscn jajaja
"""
