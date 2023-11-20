extends Equipment


func _ready() -> void:
	upgrade_list = [
		[0,1],
		[100,10],
		[100,20],
		[100,30],
		[100,40],
		[100,50],
		[100,60],
		[100,70],
		[100,80],
		[100,90],
		[100,100]
	]

	max_upgrades = upgrade_list.size() - 1
	upgrades = Globals.current_game.player_upgrades.sword
	sprite.frame = int(clamp(upgrades, 0, sprite.hframes -1))