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


func _on_HelmetButton_pressed() -> void:
	var arr : Array = helmet.get_sprite_info()
	item_show.texture = arr[0]
	item_show.hframes = arr[1]
	item_show.frame = arr[2]
	item_name = "helmet"


func _on_ChestPlateButton_pressed() -> void:
	var arr : Array = chestPlate.get_sprite_info()
	item_show.texture = arr[0]
	item_show.hframes = arr[1]
	item_show.frame = arr[2]
	item_name = "chestPlate"


func _on_GreavesButton_pressed() -> void:
	var arr : Array = greaves.get_sprite_info()
	item_show.texture = arr[0]
	item_show.hframes = arr[1]
	item_show.frame = arr[2]
	item_name = "greaves"


func _on_BootsButton_pressed() -> void:
	var arr : Array = boots.get_sprite_info()
	item_show.texture = arr[0]
	item_show.hframes = arr[1]
	item_show.frame = arr[2]
	item_name = "boots"


func _on_SwordButton_pressed() -> void:
	var arr : Array = sword.get_sprite_info()
	item_show.texture = arr[0]
	item_show.hframes = arr[1]
	item_show.frame = arr[2]
	item_name = "sword"


func _on_ShieldButton_pressed() -> void:
	var arr : Array = shield.get_sprite_info()
	item_show.texture = arr[0]
	item_show.hframes = arr[1]
	item_show.frame = arr[2]
	item_name = "shield"


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
	queue_free()
