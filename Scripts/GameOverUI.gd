extends Control


const frases : Array[String] = [
	"One more try?",
	"you aren't done yet",
	"better gear, better chances",
	"better get you gold in good use"
]


@onready var coin_label : Label = $CurrencyContainer/CoinLabel
@onready var game_over_label : Label = $GameOverLabel
@onready var return_button : Button = $ButtonContainer/ReturnButton
@onready var shop_button : Button = $ButtonContainer/ShopButton
@onready var retry_button : Button = $ButtonContainer/RetryButton
@onready var option_button : Button = $ButtonContainer/OptionsMenu


signal shop_pressed
signal retry_pressed
signal return_pressed
signal options_pressed
signal anything_pressed


func coin_label_updater(gold : int = Globals.current_game.game_info.gold) -> void:
	coin_label.text = str(gold)


func _on_ShopButton_pressed() -> void:

	emit_signal("shop_pressed")
	emit_signal("anything_pressed")


func _on_RetryButton_pressed() -> void:
	emit_signal("retry_pressed")
	emit_signal("anything_pressed")


func _on_ReturnButton_pressed() -> void:
	emit_signal("return_pressed")


func _on_options_menu_pressed() -> void:
	emit_signal("options_pressed")
	emit_signal("anything_pressed")


func appear_animation() -> void:
	game_over_label.text = frases[randi() % frases.size()]
	$AnimationPlayer.play("appear")
