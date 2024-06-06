extends CoreComponent


@onready var helmet : Equipment = $Helmet
@onready var chest_plate : Equipment = $ChestPlate
@onready var greaves : Equipment = $Greaves
@onready var boots : Equipment = $Boots
@onready var shield : Equipment = $Shield
@onready var sword : Equipment = $Sword


var total_upgrades : int 


signal player_got_hit


func _ready() -> void:
	total_upgrades = get_total_upgrades()
	update_stats()
	super()
	connect('player_got_hit', Callable(get_node('../'), 'blip'))


func revive_player() -> void:
	for i in get_child_count():
		if get_child(i) is Equipment:
			get_child(i).get_upgrades()
	total_upgrades = get_total_upgrades()
	update_stats()


# Las estadísticas después de sumar el equipamiento
func update_stats() -> void:
	# Aumentar la defensa
	defense = 20 + helmet.get_item_stats().stat + chest_plate.get_item_stats().stat \
	 + greaves.get_item_stats().stat + boots.get_item_stats().stat + shield.get_item_stats().stat

	# Aumentar el ataque
	attack = 20 + sword.get_item_stats().stat

	# Aumentar vida por numero de mejoras en total, a futuro cambiará
	@warning_ignore("integer_division")
	# Revisar que el cálculo sea correcto
	set_max_hp(200 + 200 * (total_upgrades / 2))
	#print(str(max_life) + ' - ' + str(total_upgrades))


func get_total_upgrades() -> int:
	return helmet.upgrades + chest_plate.upgrades + greaves.upgrades \
	 + boots.upgrades + shield.upgrades + sword.upgrades


func _on_CoreComponent_area_entered(area : CoreComponent) -> void:
	super(area)
	emit_signal("player_got_hit")
	

