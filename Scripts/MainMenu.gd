extends Control


@onready var versionlabel : Label = $Container/version


signal sart_pressed
signal option_pressed
signal credit_pressed


func _ready() -> void:
	versionlabel.text = "V:" + str(Globals.current_game.game_info.game_version)


func _on_StartButton_pressed() -> void:
	emit_signal("sart_pressed")


func _on_OptionButton_pressed() -> void:
	emit_signal("option_pressed")


func _on_CreditsButton_pressed() -> void:
	emit_signal("credit_pressed")

