extends Equipment


func _ready() -> void:
	upgrade_list = [
		[0,0],
		[75,70],
		[150,140],
		[225,210],
		[300,280],
		[375,350],
		[450,420],
		[525,490],
		[600,560],
		[675,630],
		[825,700]
	]

	max_upgrades = upgrade_list.size() - 1
	upgrades = Globals.current_game.player_upgrades.chestPlate
	sprite.frame = int(clamp(upgrades, 0, sprite.hframes -1))