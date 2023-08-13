extends Node2D
class_name Level

onready var physic_ground = $PhysicGround
onready var setterparallaxGround : ParallaxBackground = $SetterParallaxBackground
onready var enemySpawner : Position2D = $EnemySpawner
onready var finishing : bool = false
onready var enemy_spawner : Position2D = $EnemySpawner


var ground_speed : int = -30


func _ready() -> void:
	setterparallaxGround.set_background()

	physic_ground.constant_linear_velocity.x = ground_speed

	$GUI.first_call($Player/CoreComponent.get_stats().life)

	enemy_spawner.start_timer()


func _on_MataSobras5000_body_exited(body : Node) -> void:
	print(str(body) + ' has been deleted from existence')
	body.queue_free()


func start_game() -> void: # Llamado por el AnimationPlayer
	setterparallaxGround.get_child(0).set_paraspeed(ground_speed)


func finish_game() -> void: # Llamado cuando el jugador manda la señal morido
	$GameOverUI.visible = true

	$Accelerator/AnimationPlayer.play_backwards('accelerate')
	
	enemy_spawner.stop_timer()


func _on_Accelerator_value_changed(value:float) -> void:
	physic_ground.constant_linear_velocity.x = ground_speed * value
	setterparallaxGround.get_child(0).set_paraspeed(ground_speed * value)
