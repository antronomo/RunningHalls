extends Node

const coin : PackedScene = preload("res://Components/Coin.tscn")


func _ready():
    randomize()


# FUNCIONES CON CurrentGame.gd
func start_new_game():pass


func resume_game():pass


func finish_current_game():pass


# FUNCIONES CON Config.gd
func save_new_config():pass


func set_default_config():pass


# OTROS

func _input(event) -> void:
    if event.is_action_pressed("ui_accept"):
        OS.window_fullscreen = !OS.window_fullscreen
