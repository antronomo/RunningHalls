extends CanvasLayer


@onready var health_bar : TextureProgressBar = $HealthBarContainer/HealthBar
@onready var health_label : Label = $HealthBarContainer/Label
@onready var coin_label : Label = $CurrencyContainer/Label
@onready var pause_button : Button = $PauseButton

# SpeedButtons
@onready var speed_button_1 : Button = $SpeedControllerContainer/SpeedButton1
@onready var speed_button_2 : Button = $SpeedControllerContainer/SpeedButton2
@onready var speed_button_3 : Button = $SpeedControllerContainer/SpeedButton3


func _ready() -> void:
	coin_label.text = str(0)
	health_label.text = str(0)
	
	update_speed_buttons_focus()


func update_speed_buttons_focus() -> void:
	match Globals.config_data.time_speed:
		0:
			speed_button_1.button_pressed = true
		1:
			speed_button_2.button_pressed = true
		2:
			speed_button_3.button_pressed = true
		_:
			push_warning("cannot set button pressed")


func first_call(max_player_health : int) -> void:
	health_bar.max_value = max_player_health
	health_bar.value = max_player_health

	health_label.text = str(max_player_health)


func update_helath_bar(new_player_health : int) -> void : 
	health_bar.value = new_player_health
	health_label.text = str(new_player_health)


func update_gold_label(new_gold_count : int) -> void:
	coin_label.text = str(new_gold_count)


func _on_pause_button_pressed() -> void:
	pause_button.release_focus()


func _on_speed_button_1_pressed() -> void:
	speed_button_1.release_focus()
	speed_button_1.button_pressed = true
	speed_button_2.button_pressed = false
	speed_button_3.button_pressed = false


func _on_speed_button_2_pressed() -> void:
	speed_button_2.release_focus()
	speed_button_1.button_pressed = false
	speed_button_2.button_pressed = true
	speed_button_3.button_pressed = false


func _on_speed_button_3_pressed() -> void:
	speed_button_3.release_focus()
	speed_button_1.button_pressed = false
	speed_button_2.button_pressed = false
	speed_button_3.button_pressed = true

