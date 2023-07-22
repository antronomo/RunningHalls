extends ParallaxBackground


# onready var layer5 : ParallaxLayer = $ParallaxLayer5
onready var layer4 : ParallaxLayer = $ParallaxLayer4
onready var layer3 : ParallaxLayer = $ParallaxLayer3
onready var layer2 : ParallaxLayer = $ParallaxLayer2
onready var layer1 : ParallaxLayer = $ParallaxLayer


var parallaxSpeed : int = -30


func _physics_process(delta) -> void:
	layer4.motion_offset.x += (parallaxSpeed + 15) * delta
	layer3.motion_offset.x += (parallaxSpeed + 10) * delta
	layer2.motion_offset.x += (parallaxSpeed + 5) * delta
	layer1.motion_offset.x += parallaxSpeed * delta
