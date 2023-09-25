extends Control


signal sart_pressed
signal option_pressed
signal credit_pressed


func _on_StartButton_pressed() -> void:
	emit_signal("sart_pressed")


func _on_OptionButton_pressed() -> void:
	emit_signal("option_pressed")


func _on_CreditsButton_pressed() -> void:
	emit_signal("credit_pressed")

