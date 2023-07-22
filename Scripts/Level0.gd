extends Node2D
class_name Level


var groundSpeed : int = -30


onready var parallaxGround : ParallaxBackground = $SewerParallaxBackground
onready var enemySpawner : Position2D = $EnemySpawner
onready var timer : Timer = $Timer


func _ready() -> void:
	randomize()
	$PhysicGround.constant_linear_velocity.x = groundSpeed


func _on_MataSobras5000_body_exited(body : Node) -> void:
	print(str(body) + ' has been deleted from existence')
	body.queue_free()


func start_timer() -> void:
	timer.start()


func _on_Timer_timeout() -> void:
	enemySpawner.spawn_new_enemy()


func start_game() -> void:
	start_timer()
	parallaxGround.set_paraspeed(groundSpeed)
