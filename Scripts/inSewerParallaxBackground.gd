extends ParallaxBackground


onready var layer1 : ParallaxLayer = $ParallaxLayer
onready var layer2 : ParallaxLayer = $ParallaxLayer2


var parallaxSpeed : int = 0 setget set_paraspeed, get_paraspeed
var mayimove : bool = false


func set_paraspeed(new_speed : int) -> void:
	parallaxSpeed = new_speed
	mayimove = true


func get_paraspeed() -> int: 
	return parallaxSpeed


func _physics_process(delta) -> void:
	if mayimove:
		layer2.motion_offset.x += parallaxSpeed * delta
		layer1.motion_offset.x += (parallaxSpeed + 5) * delta

