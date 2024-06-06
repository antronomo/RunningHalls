extends Equipment


func _ready() -> void:
	upgrade_list = [
		[0,0],
		[50,30],
		[100,60],
		[150,90],
		[200,120],
		[250,150],
		[300,180],
		[350,210],
		[400,240],
		[450,270],
		[500,300]
	]

	max_upgrades = upgrade_list.size() - 1
	get_upgrades()


func get_upgrades() -> void:
	upgrades = Globals.current_game.player_upgrades.sword
	sprite.frame = int(clamp(upgrades, 0, sprite.hframes -1))
