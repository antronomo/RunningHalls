extends Control


# Me mola, pero no tiene nada que hacer en este proyecto
@onready var item_show : Sprite2D = $TabContainer/ForgeTab/SelectRect/ItemShow 

@onready var tab_container : TabContainer = $TabContainer
@onready var upgrade_name_label : Label = $TabContainer/ForgeTab/InfoRect/UpgradeName
@onready var upgrade_stat_label : Label = $TabContainer/ForgeTab/InfoRect/UpgradeStat
@onready var upgrade_price_label : Label = $TabContainer/ForgeTab/InfoRect/UpgradePrice
@onready var goldLabel : Label = $TabContainer/ForgeTab/GoldContainer/Label
@onready var player_stats_label : Label = $StatsLabel
@onready var upgrade_button : Button = $TabContainer/ForgeTab/UpgradeButton

#@onready var helmet_button : Button = $TabContainer/ForgeTab/HelmetButton
#@onready var chest_plate_button : Button = $TabContainer/ForgeTab/ChestPlateButton
#@onready var greaves_button : Button = $TabContainer/ForgeTab/GreavesButton
#@onready var boots_button : Button = $TabContainer/ForgeTab/BootsButton
#@onready var sword_button : Button = $TabContainer/ForgeTab/SwordButton
#@onready var shield_button : Button = $TabContainer/ForgeTab/ShieldButton

@onready var helmet : Equipment = $TabContainer/ForgeTab/HelmetButton/Helmet
@onready var chest_plate : Equipment = $TabContainer/ForgeTab/ChestPlateButton/ChestPlate
@onready var greaves : Equipment = $TabContainer/ForgeTab/GreavesButton/Greaves
@onready var boots : Equipment = $TabContainer/ForgeTab/BootsButton/Boots
@onready var sword : Equipment = $TabContainer/ForgeTab/SwordButton/Sword
@onready var shield : Equipment = $TabContainer/ForgeTab/ShieldButton/Shield


var item_name : String
var gold : int
var upgrade_price : int


signal exiting
signal anything_pressed


func _ready() -> void:
	tab_container.current_tab = 0
	update_stats_label()


func gold_update() -> void:
	gold = Globals.current_game.game_info.gold
	goldLabel.text = str(gold)


func _on_HelmetButton_pressed() -> void:
	get_item_to_show(helmet, "helmet")
	emit_signal("anything_pressed")


func _on_ChestPlateButton_pressed() -> void:
	get_item_to_show(chest_plate, "chest plate")
	emit_signal("anything_pressed")


func _on_GreavesButton_pressed() -> void:
	get_item_to_show(greaves, "greaves")
	emit_signal("anything_pressed")


func _on_BootsButton_pressed() -> void:
	get_item_to_show(boots, "boots")
	emit_signal("anything_pressed")


func _on_SwordButton_pressed() -> void:
	get_item_to_show(sword, "sword")
	emit_signal("anything_pressed")
	

func _on_ShieldButton_pressed() -> void:
	get_item_to_show(shield, "shield")
	emit_signal("anything_pressed")


func get_item_to_show(equipment : Equipment, new_item_name : String) -> void:
	item_name = new_item_name
	
	var sprite_info : Dictionary = equipment.get_sprite_info()
	item_show.texture = sprite_info.texture
	item_show.hframes = sprite_info.hframes
	item_show.frame = sprite_info.frame
	
	var def_or_atk : String = "attack" if item_name == "sword" else "deff" # Solucion de vagos
	
	var equipment_info : Dictionary = equipment.get_item_stats()
	upgrade_name_label.text = new_item_name
	if equipment_info.level < equipment_info.max_upgrades:
		var equipment_next_info : Dictionary = equipment.get_item_stats(1)
		upgrade_stat_label.text = def_or_atk + " \n" + \
			str(equipment_info.stat) + "  ->  " + str(equipment_next_info.stat)
		
		upgrade_price = equipment_next_info.price
		upgrade_price_label.text = str(upgrade_price) + " coins"
		
	else:
		upgrade_stat_label.text = def_or_atk + " \n" + str(equipment_info.stat)
		
		upgrade_price = 9223372036854775807 # Esto empezó como broma y así se quedó
		upgrade_price_label.text = "MAX"


func _on_UpgradeButton_pressed() -> void:
	if upgrade_price <= gold and upgrade_price != 9223372036854775807:
		gold = gold - upgrade_price
		goldLabel.text = str(gold)
		
		match item_name:
			"helmet":
				helmet.upgrade()
				_on_HelmetButton_pressed()
				
			"chest plate":
				chest_plate.upgrade()
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
				push_error("item_name not found")
				
	else:
		print("Can not upgrade!")
	
	emit_signal("anything_pressed")
	update_stats_label()


func save_upgrades() -> void:
	Globals.set_game_data("helmet", helmet.upgrades)
	Globals.set_game_data("chest_plate", chest_plate.upgrades)
	Globals.set_game_data("greaves", greaves.upgrades)
	Globals.set_game_data("boots", boots.upgrades)
	Globals.set_game_data("sword", sword.upgrades)
	Globals.set_game_data("shield", shield.upgrades)


func _on_ForgeButton_pressed() -> void:
	tab_container.current_tab = 0
	emit_signal("anything_pressed")


func update_stats_label() -> void:
	save_upgrades()
	
	# Literal un copy/paste del PlayerStats.gd
	var defense = 20 + helmet.get_item_stats().stat + chest_plate.get_item_stats().stat \
	 + greaves.get_item_stats().stat + boots.get_item_stats().stat + shield.get_item_stats().stat
	
	var attack = 20 + sword.get_item_stats().stat
	
	var total_upgrades : int = helmet.upgrades + chest_plate.upgrades + greaves.upgrades \
	 + boots.upgrades + shield.upgrades + sword.upgrades
	@warning_ignore("integer_division")
	var hp : int = 200 + 200 * (total_upgrades / 2)
	# ----------------------------------------
	
	player_stats_label.text = "HP: " + "\n" + str(hp) + "\n" + "\n" \
	+ "attack: " + "\n" + str(attack) + "\n" + "\n" \
	+ "deff: " + "\n" + str(defense) + "\n"


func _on_ExitButton_pressed() -> void:
	Globals.set_game_data("gold", gold)
	save_upgrades()
	tab_container.current_tab = 0
	upgrade_button.grab_focus()
	upgrade_button.release_focus()
	emit_signal("exiting")
	emit_signal("anything_pressed")

