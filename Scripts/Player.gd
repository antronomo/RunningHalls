extends Node2D

onready var sprit : Sprite = $Sprite 

#Cargando estats, talvez así sea más fácil retocarlos a futuro
onready var heal_points : float = stats.hp setget set_hp, get_hp
onready var attack : int = stats.atk
onready var deffense : int = stats.deff
onready var critical_cahnce : int = stats.crit_chance
onready var critical_damage : int = stats.crit_dmg

export var stats : Resource
export var luck : int = 0

func _ready() -> void :
	sprit.texture = stats.sprite_texture

func _on_AttackBox_body_entered(body : Node) -> void:
	if body.is_in_group('enemy'):
		#Intento de hacer que los enemigos reciban 'nockback', ¿Debería poner esto en enemy?
		body.apply_central_impulse(Vector2(100, ((randi()%125 + 25) * -1)))  #(randi()%25 + 125) * -1)
		body.get_hurt(hit())

func get_hurt(entring_dmg : float) -> void: 
	var diff : float =  (entring_dmg * 100) / deffense

	set_hp(((diff * entring_dmg) / 100) * -1)

func hit() -> float:
	var dmg : float = (attack * (randi() % 50 + 75)) / 100

	if randi()%101 <= critical_cahnce:
		dmg += (dmg * critical_damage) / 100
		print('Critical')
	# var diff : float = (dmg * 100) / objective
	# return (diff * dmg) / 100
	return dmg

func set_hp(changer : float) -> void: #Recuerda, valores negativos para 'dañar' y positivos para 'curar'
	heal_points += changer

	if heal_points <= 0:
		print('Player died')
	else:
		print('Player current hp: ' + str(heal_points))

func get_hp() -> float:
	return heal_points

func die() -> void : pass
