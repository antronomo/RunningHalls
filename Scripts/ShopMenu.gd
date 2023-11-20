extends Control


onready var item_show : Sprite = $TabContainer/ForgeTab/SelectRect/ItemShow
onready var tab_container : TabContainer = $TabContainer

onready var helmet : Equipment = $TabContainer/ForgeTab/HelmetButton/Helmet
onready var chestPlate : Equipment = $TabContainer/ForgeTab/ChestPlateButton/ChestPlate
onready var greaves : Equipment = $TabContainer/ForgeTab/GreavesButton/Greaves
onready var boots : Equipment = $TabContainer/ForgeTab/BootsButton/Boots
onready var sword : Equipment = $TabContainer/ForgeTab/SwordButton/Sword
onready var shield : Equipment = $TabContainer/ForgeTab/ShieldButton/Shield


var item_name : String


signal exiting


func _on_HelmetButton_pressed() -> void:
	get_item_to_show(helmet.get_sprite_info(), "helmet")


func _on_ChestPlateButton_pressed() -> void:
	get_item_to_show(chestPlate.get_sprite_info(), "chestPlate")


func _on_GreavesButton_pressed() -> void:
	get_item_to_show(greaves.get_sprite_info(), "greaves")


func _on_BootsButton_pressed() -> void:
	get_item_to_show(boots.get_sprite_info(), "boots")


func _on_SwordButton_pressed() -> void:
	get_item_to_show(sword.get_sprite_info(), "sword")


func _on_ShieldButton_pressed() -> void:
	get_item_to_show(shield.get_sprite_info(), "shield")


func get_item_to_show(sprite_info : Array, name : String) -> void:
	item_show.texture = sprite_info[0]
	item_show.hframes = sprite_info[1]
	item_show.frame = sprite_info[2]
	item_name = name


func _on_UpgradeButton_pressed() -> void:
	match item_name:
		"helmet": 
			helmet.upgrade()
			_on_HelmetButton_pressed()

		"chestPlate":
			chestPlate.upgrade()
			_on_ChestPlateButton_pressed()

		"greaves": 
			greaves.upgrade()
			_on_GreavesButton_pressed()

		"boots": 
			boots.upgrade()
			_on_BootsButton_pressed()

		"sword": 
			sword.upgrade()
			_on_SwordButton_pressed()

		"shield": 
			shield.upgrade()
			_on_ShieldButton_pressed()

		_:
			print("Nothing selected!")


func save_upgrades() -> void:
	Globals.set_game_data("helmet", helmet.upgrades)
	Globals.set_game_data("chestPlate", chestPlate.upgrades)
	Globals.set_game_data("greaves", greaves.upgrades)
	Globals.set_game_data("boots", boots.upgrades)
	Globals.set_game_data("sword", sword.upgrades)
	Globals.set_game_data("shield", shield.upgrades)
	Globals.save_data_to_file()


func _on_ForgeButton_pressed() -> void:
	tab_container.current_tab = 0


func _on_StatsButton_pressed() -> void:
	tab_container.current_tab = 1
	$TabContainer/PlayerStats/StatsLabel.text = str(Globals.current_game.duplicate())


func _on_ExitButton_pressed() -> void:
	save_upgrades()
	emit_signal("exiting")
