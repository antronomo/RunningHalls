extends Enemy


func _ready() -> void:
	super()
	anim_sprite.animation = "Brown" if randi() % 2 == 0 else "Silver"


# Repetí la función aquí porque la rata tiene un sprite más pequeño,
# o entiendo como van las funciones heredadas o hago el sprite mas grande 
func boss_mode() -> void:
	if !im_boss:
		anim_sprite.position = Vector2(8, -8)
		anim_sprite.scale = Vector2(2, 2)
		health_bar.position = Vector2(-8, -48)
		health_bar.scale = Vector2(2, 2)
		core_compo.boss_buff()
		im_boss = true
	
		set_up_health_bar()
