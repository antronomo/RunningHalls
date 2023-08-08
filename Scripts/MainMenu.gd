extends Control


onready var start_button : Button = $VBoxContainer3/StartButton
onready var option_button : Button = $VBoxContainer3/OptionButton
onready var credit_button : Button = $VBoxContainer3/CreditsButton


func _on_Button_pressed() -> void:
	get_tree().change_scene('res://Level/Level0.tscn')


func _on_CreditsButton_pressed() -> void:
	pass # Replace with function body.


func _on_OptionButton_pressed() -> void:
	pass # Replace with function body.


func _on_MenuScene_enable_buttons(turn_it : bool) -> void:
	start_button.disabled = !turn_it
	option_button.disabled = !turn_it
	credit_button.disabled = !turn_it