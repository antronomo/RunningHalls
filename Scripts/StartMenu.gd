extends Control


signal new_game_pressed
signal resume_pressed
signal return_pressed


func _on_ResumeButton_pressed() -> void:
	emit_signal("resume_pressed")


func _on_NewGameButton_pressed() -> void:
	emit_signal("new_game_pressed")


func _on_ReturnButton_pressed() -> void:
	emit_signal("return_pressed")
