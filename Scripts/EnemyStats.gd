extends CoreComponent


@onready var body : Enemy = get_node("../")


var wave_multiplier : float = 0.1
var boss_multiplier : float = 2.0
var current_wave : int = 0


func _ready() -> void:
	connect("body_entered", Callable(self, "_on_EnemyStats_body_entered" ))
	
	current_wave = clamp(Globals.current_game.game_info.wave, 0 , 150)
	#print(str(current_wave))
	wave_buff()
	
	super()


func print_stats() -> void:
	print(JSON.stringify(get_stats(), "\t"))


func wave_buff() -> void:
	@warning_ignore("narrowing_conversion")
	set_max_hp(max_life + max_life * (current_wave * wave_multiplier))
	@warning_ignore("narrowing_conversion")
	attack += attack * (current_wave * wave_multiplier)
	@warning_ignore("narrowing_conversion")
	defense += defense * (current_wave * wave_multiplier)
	# critical_chance += critical_chance * (current_wave * 0.01)
	# critical_damage += critical_damage * (current_wave * 0.01)
	
	# print_stats()


func boss_buff() -> void:
	@warning_ignore("narrowing_conversion")
	set_max_hp(max_life * boss_multiplier)
	@warning_ignore("narrowing_conversion")
	attack *= boss_multiplier
	@warning_ignore("narrowing_conversion")
	defense *= boss_multiplier
	# critical_chance *= boss_multiplier
	# critical_damage *= boss_multiplier
	
	# print_stats()


func _on_CoreComponent_area_entered(area : CoreComponent) -> void:
	body.knock_back()
	super(area)
