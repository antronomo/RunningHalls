extends Node2D
class_name Level


var groundSpeed : int = -30


onready var setterparallaxGround : ParallaxBackground = $SetterParallaxBackground
onready var enemySpawner : Position2D = $EnemySpawner
onready var timer : Timer = $Timer


func _ready() -> void:
	randomize()

	setterparallaxGround.set_background()

	$PhysicGround.constant_linear_velocity.x = groundSpeed

	$GUI.first_call($Player/CoreComponent.get_stats().life)


func _on_MataSobras5000_body_exited(body : Node) -> void:
	print(str(body) + ' has been deleted from existence')
	body.queue_free()


func start_timer() -> void:
	timer.start()


func _on_Timer_timeout() -> void:
	enemySpawner.spawn_new_enemy()


func start_game() -> void:
	start_timer()
	setterparallaxGround.get_child(0).set_paraspeed(groundSpeed)
