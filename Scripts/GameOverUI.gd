extends Control


@onready var coin_label : Label = $CurrencyContainer/CoinLabel


signal shop_pressed
signal retry_pressed
signal return_pressed
signal options_pressed
signal anything_pressed


func _ready() -> void:
	visible = false


func coin_label_updater() -> void:
	coin_label.text = str(Globals.current_game.game_info.gold)


func _on_ShopButton_pressed() -> void:
	emit_signal("shop_pressed")
	emit_signal("anything_pressed")


func _on_RetryButton_pressed() -> void:
	emit_signal("retry_pressed")
	emit_signal("anything_pressed")


func _on_ReturnButton_pressed() -> void:
	emit_signal("return_pressed")
	#emit_signal("anything_pressed")


func _on_options_menu_pressed() -> void:
	emit_signal("options_pressed")
	emit_signal("anything_pressed")


func _on_GameOverUI_visibility_changed() -> void:
	if visible:
		$AnimationPlayer.play("appear")

