extends Node2D
class_name Level


var groundSpeed : int = -32


onready var parallaxGround : ParallaxLayer = $ParallaxBackground/Ground
onready var enemySpawner : Position2D = $EnemySpawner


func _ready() -> void:
	randomize()


func _process(delta) -> void:
	parallaxGround.motion_offset.x += groundSpeed * delta


func _on_MataSobras5000_body_exited(body : Node) -> void:
	print(str(body) + ' has been deleted from existence')
	body.queue_free()


func _on_Timer_timeout() -> void:
	enemySpawner.spawn_new_enemy()
