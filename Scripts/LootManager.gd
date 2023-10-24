extends Node2D


const coin_scene : PackedScene = preload("res://Components/Coin.tscn")


func generate_loot(loot_position : Vector2, quantity : int) -> void:
	var coin : = coin_scene.instance()
	coin.amount = quantity
	coin.position = loot_position
	add_child(coin)
