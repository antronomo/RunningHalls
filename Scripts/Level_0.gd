extends Node2D
class_name Level

var groundSpeed : int = -32
var packedWizard : PackedScene = preload("res://Enemyes/DarkWizard.tscn")

onready var parallaxGround : ParallaxLayer = $ParallaxBackground/Ground

func _ready():
	randomize()

func _process(delta) -> void :
	parallaxGround.motion_offset.x += groundSpeed * delta

func _on_Timer_timeout():
	var newEnemy = packedWizard.instance()
	add_child(newEnemy)
	newEnemy.position = $EnemySpawner.position