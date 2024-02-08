extends CoreParallaxBackground


@onready var layer4 : ParallaxLayer = $ParallaxLayer4
@onready var layer3 : ParallaxLayer = $ParallaxLayer3
@onready var layer2 : ParallaxLayer = $ParallaxLayer2
@onready var layer1 : ParallaxLayer = $ParallaxLayer


func _physics_process(delta) -> void:
	if may_i_move:
		layer4.motion_offset.x += (parallax_speed - parallax_speed * 0.45) * delta
		layer3.motion_offset.x += (parallax_speed - parallax_speed * 0.35) * delta
		layer2.motion_offset.x += (parallax_speed - parallax_speed * 0.25) * delta
		layer1.motion_offset.x += parallax_speed * delta
