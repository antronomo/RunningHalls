extends CanvasLayer


@onready var health_bar : TextureProgressBar = $HealthBarContainer/HealthBar
@onready var health_label : Label = $HealthBarContainer/Label
@onready var coin_label : Label = $CurrencyContainer/Label
@onready var pause_button : Button = $PauseButton
@onready var speed_button : Button = $SpeedControllerContainer/SpeedButton
@onready var speed_button_label : Label = $SpeedControllerContainer/SpeedButton/Label


func _ready() -> void:
	coin_label.text = str(0)
	health_label.text = str(0)


func first_call(max_player_health : int) -> void: # Cambiar nombre?
	health_bar.max_value = max_player_health
	health_bar.value = max_player_health
	
	health_label.text = str(max_player_health)
	
	var number : int  = Globals.config_data.time_speed -1 if not Globals.config_data.time_speed == 0 else 2
	_on_speed_button_pressed(number)


func update_helath_bar(new_player_health : int) -> void: 
	health_bar.value = new_player_health
	health_label.text = str(new_player_health)


func update_gold_label(new_gold_count : int) -> void:
	coin_label.text = str(new_gold_count)


func _on_pause_button_pressed() -> void:
	pause_button.release_focus()


func _on_speed_button_pressed(number : int = Globals.config_data.time_speed) -> void:
	speed_button.release_focus()
	match number:
		0:
			speed_button_label.text = ">>"
		
		1:
			speed_button_label.text = ">>>"
		
		2:
			speed_button_label.text = ">"
		
		_:
			push_warning("Error at changing speed label text")

