extends RigidBody2D
class_name Enemy

onready var sprit : Sprite = $Sprite

export var my_name : String 
export var heal_points : int = 0 setget set_hp, get_hp
export var attack : int 
export var deffense : int 
export var critical_cahnce : int 
export var critical_damage : int 

func _ready() -> void :
	set_mode(2)

func _on_HitBox_area_entered(area:Area2D) -> void:
	if area.is_in_group('player'):
		area.get_hurt()

func get_hurt(entring_dmg : float) -> void:
	print('Reciving ' + str(entring_dmg))
	var diff : float =  (entring_dmg * 100) / deffense
	var final_dmg : float = ((diff * entring_dmg) / 100)* -1
	print('final dmg: ' + str(final_dmg))
	set_hp(final_dmg)

func hit() -> float:
	var dmg : float = (attack * randi()%50 + 75) / 100

	if randi()%101 <= critical_cahnce:
		dmg += (dmg * critical_damage) / 100
		
	# var diff : float = (dmg * 100) / objective
	
	# return (diff * dmg) / 100
	return dmg

func set_hp(changer : int) -> void: #Recuerda, valores negativos para 'dañar' y positivos para 'curar'
	heal_points += changer

	if heal_points <= 0:
		die()
	else:
		print(my_name + ' current hp: ' + str(heal_points))

func get_hp() -> int:
	return heal_points

func die() -> void :
	print(my_name + ' se ha morido!')
	queue_free()