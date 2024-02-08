extends Control


@onready var health_bar : TextureProgressBar = $HealthBarContainer/HealthBar
@onready var health_label : Label = $HealthBarContainer/Label
@onready var coin_label : Label = $CurrencyContainer/Label


func _ready() -> void:
	coin_label.text = str(0)


func first_call(maxHP : int) -> void:
	health_bar.max_value = maxHP
	health_bar.value = maxHP

	health_label.text = str(maxHP)


func update_helath_bar(newHP : int) -> void : 
	health_bar.value = newHP
	health_label.text = str(newHP)


func update_gold_label(new_gold : int) -> void:
	coin_label.text = str(new_gold)


"""
He perdido como 30 minutos porque no podía llamar la función 'first_call', 
resulta que no asigné el script a la escena GUI.tscn jajaja
"""
