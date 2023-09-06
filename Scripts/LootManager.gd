extends Node2D


func generate_loot(loot_position : Vector2, quantity : int) -> void:
	var coin : = Globals.coin.instance()
	coin.amount = quantity
	coin.position = loot_position
	add_child(coin)
