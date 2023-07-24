extends CoreParallaxBackground


# onready var layer5 : ParallaxLayer = $ParallaxLayer5
onready var layer4 : ParallaxLayer = $ParallaxLayer4
onready var layer3 : ParallaxLayer = $ParallaxLayer3
onready var layer2 : ParallaxLayer = $ParallaxLayer2
onready var layer1 : ParallaxLayer = $ParallaxLayer


func _physics_process(delta) -> void:
	if may_i_move:
		layer4.motion_offset.x += (parallax_speed + 15) * delta
		layer3.motion_offset.x += (parallax_speed + 10) * delta
		layer2.motion_offset.x += (parallax_speed + 5) * delta
		layer1.motion_offset.x += parallax_speed * delta
