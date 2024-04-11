extends Enemy


signal hand_died


func _ready() -> void:
	super()
	connect("hand_died", Callable(get_node("../"), "_on_hand_died"))

func _on_sprite_2d_animation_finished() -> void:
	if anim_sprite.animation == "Attack":
		anim_sprite.animation = "Walking"
		anim_sprite.play()


func _on_CoreComponent_area_entered(area) -> void:
	anim_sprite.animation = "Attack"


func hecking_die() -> void:
	emit_signal("hand_died")
	queue_free()
