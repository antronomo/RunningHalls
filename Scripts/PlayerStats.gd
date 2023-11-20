extends CoreComponent


onready var helmet : Equipment = $Helmet
onready var chest_plate : Equipment = $ChestPlate
onready var greaves : Equipment = $Greaves
onready var boots : Equipment = $Boots
onready var shield : Equipment = $Shield
onready var sword : Equipment = $Sword


func _ready() -> void:
	fixed_stats()
	# print(str(get_stats()))


# Las estadísticas después de sumar el equipamiento
func fixed_stats() -> void:
	defense = defense + helmet.get_item_stats().stat + chest_plate.get_item_stats().stat + greaves.get_item_stats().stat + boots.get_item_stats().stat + shield.get_item_stats().stat

	attack = attack + sword.get_item_stats().stat

