extends Enemy


onready var anim_sprite : AnimatedSprite = $AnimatedSprite


func _on_AnimatedSprite_animation_finished():
	var anim : String = anim_sprite.animation
	
	if anim == "CapuchaTime": 
		anim_sprite.animation = 'Walk2'
	elif anim == "CapuchantTime": 
		anim_sprite.animation = 'Walk1'


func _on_CoreComponent_low_life(status : bool):
	if low_life_status != status:
		if status: 
			anim_sprite.animation = 'CapuchaTime'
		else: 
			anim_sprite.animation = 'CapuchantTime'
