extends Equipment


func _ready() -> void:
	upgrade_list = [
		[0,0],
		[50,20],
		[100,40],
		[150,60],
		[200,80],
		[250,100],
		[300,120],
		[350,140],
		[400,160],
		[450,180],
		[500,200]
	]

	max_upgrades = upgrade_list.size() - 1
	upgrades = Globals.current_game.player_upgrades.shield
	sprite.frame = int(clamp(upgrades, 0, sprite.hframes -1))