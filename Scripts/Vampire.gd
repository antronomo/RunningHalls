extends Enemy


func _on_AnimatedSprite_animation_finished() -> void:
	var anim : String = anim_sprite.animation
	
	match anim:
		"CapuchaTime":
			anim_sprite.animation = "Walk2"
		"CapuchantTime":
			anim_sprite.animation = "Walk1"


func update_status(status : String, value : bool) -> void:
	match status:
		"low_life":
			if dict_status.low_life != value:
				if value: 
					anim_sprite.animation = "CapuchaTime"
				else: 
					anim_sprite.animation = "DescapuchaTime"
			dict_status.low_life = value

		_:
			print(status + " not found")
