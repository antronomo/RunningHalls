extends Equipment


func _ready() -> void:
	upgrade_list = [
		[0,0],
		[10,10],
		[15,20],
		[20,30],
		[25,40],
		[30,50],
		[35,60],
		[40,70],
		[45,80],
		[50,90],
		[55,100]
	]

	max_upgrades = upgrade_list.size() - 1
	get_upgrades()


func get_upgrades() -> void:
	upgrades = Globals.current_game.player_upgrades.boots
	sprite.frame = int(clamp(upgrades, 0, sprite.hframes -1))


