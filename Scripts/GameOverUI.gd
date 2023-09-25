extends Control


signal shop_pressed
signal retry_pressed
signal return_pressed


func _ready():
	visible = false


func _on_ShopButton_pressed() -> void:
	emit_signal("shop_pressed")


func _on_RetryButton_pressed() -> void:
	emit_signal("retry_pressed")


func _on_ReturnButton_pressed() -> void:
	emit_signal("return_pressed")


func _on_GameOverUI_visibility_changed() -> void:
	if visible:
		$AnimationPlayer.play('appear')
