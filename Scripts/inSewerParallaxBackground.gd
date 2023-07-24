extends CoreParallaxBackground


onready var layer1 : ParallaxLayer = $ParallaxLayer
onready var layer2 : ParallaxLayer = $ParallaxLayer2


func _physics_process(delta) -> void:
	if may_i_move:
		layer2.motion_offset.x += parallax_speed * delta
		layer1.motion_offset.x += (parallax_speed + 5) * delta

