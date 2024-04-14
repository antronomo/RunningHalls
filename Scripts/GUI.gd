extends CanvasLayer


@onready var health_bar : TextureProgressBar = $HealthBarContainer/HealthBar
@onready var health_label : Label = $HealthBarContainer/Label
@onready var coin_label : Label = $CurrencyContainer/Label


func _ready() -> void:
	coin_label.text = str(0)
	health_label.text = str(0)


func first_call(max_player_health : int) -> void:
	health_bar.max_value = max_player_health
	health_bar.value = max_player_health

	health_label.text = str(max_player_health)


func update_helath_bar(new_player_health : int) -> void : 
	health_bar.value = new_player_health
	health_label.text = str(new_player_health)


func update_gold_label(new_gold_count : int) -> void:
	coin_label.text = str(new_gold_count)
