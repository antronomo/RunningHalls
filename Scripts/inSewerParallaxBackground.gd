extends CoreParallaxBackground


@onready var layer2 : ParallaxLayer = $ParallaxLayer2
@onready var layer1 : ParallaxLayer = $ParallaxLayer


func _physics_process(delta) -> void:
	if may_i_move:
		layer2.motion_offset.x += (parallax_speed - parallax_speed * 0.3) * delta
		layer1.motion_offset.x += parallax_speed * delta

