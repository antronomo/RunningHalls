extends Control


func _on_RestartButton_pressed() -> void:
	get_tree().reload_current_scene()


func _on_ReturnButton_pressed() -> void:
	get_tree().change_scene('res://UIs/MainMenu.tscn')


func appear() -> void:
	$AnimationPlayer.play('appear')