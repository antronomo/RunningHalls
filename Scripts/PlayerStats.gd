extends CoreComponent


onready var helmet : Equipment = $Helmet
onready var chest_plate : Equipment = $ChestPlate
onready var greaves : Equipment = $Greaves
onready var boots : Equipment = $Boots
onready var shield : Equipment = $Shield
onready var sword : Equipment = $Sword


var total_upgrades : int 


func _ready() -> void:
	total_upgrades = get_total_upgrades()
	update_stats()


# Las estadísticas después de sumar el equipamiento
func update_stats() -> void:
	# Aumentar la defensa
	defense += helmet.get_item_stats().stat + chest_plate.get_item_stats().stat + greaves.get_item_stats().stat + boots.get_item_stats().stat + shield.get_item_stats().stat

	# Aumentar el ataque
	attack += sword.get_item_stats().stat

	# Aumentar vida por numero de mejoras en total, a futuro cambiará
	set_max_hp(max_life + max_life * (total_upgrades / 2))
	# print(str(max_life) + ' - ' + str(total_upgrades))


func get_total_upgrades() -> int:
	return helmet.upgrades + chest_plate.upgrades + greaves.upgrades + boots.upgrades + shield.upgrades + sword.upgrades
