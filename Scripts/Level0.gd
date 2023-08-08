extends Node2D
class_name Level

onready var physic_ground = $PhysicGround
onready var setterparallaxGround : ParallaxBackground = $SetterParallaxBackground
onready var enemySpawner : Position2D = $EnemySpawner
onready var timer : Timer = $Timer
onready var finishing : bool = false


var ground_speed : int = -30


func _ready() -> void:
	randomize()

	setterparallaxGround.set_background()

	physic_ground.constant_linear_velocity.x = ground_speed

	$GUI.first_call($Player/CoreComponent.get_stats().life)


func _on_MataSobras5000_body_exited(body : Node) -> void:
	print(str(body) + ' has been deleted from existence')
	body.queue_free()


func _on_Timer_timeout() -> void:
	enemySpawner.spawn_new_enemy()


func start_game() -> void: # Llamado con el AnimationPlayer
	timer.start()
	setterparallaxGround.get_child(0).set_paraspeed(ground_speed)


func finish_game() -> void: # Llamado cuando el jugador manda la señal (al llegar a 0 de hp)
	$GameOverUI.visible = true

	timer.stop()

	$Accelerator/AnimationPlayer.play('desaccelerate')


func _on_Accelerator_value_changed(value:float) -> void:
	physic_ground.constant_linear_velocity.x = ground_speed * value
	setterparallaxGround.get_child(0).set_paraspeed(ground_speed * value)
