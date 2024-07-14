extends Node2D


const coin_scene : PackedScene = preload("res://Components/Coin.tscn")


func generate_loot(loot_position : Vector2) -> void:
	var coin : = coin_scene.instantiate()
	coin.amount = randi() % 10 + 6
	coin.position = loot_position
	add_child(coin)


"""
De veras que quiero hacer que las monedas vallan directamente al icono de las monedas del gui
pero siento que no es prioridad
"""
