extends Node2D

onready var sprit : Sprite = $Sprite 

#Cargando estats, talvez así sea más fácil retocarlos a futuro
export var heal_points : float = 0 setget set_hp, get_hp
export var attack : int 
export var deffense : int 
export var critical_cahnce : int 
export var critical_damage : int 

export var luck : int = 0

func _ready() -> void :
	pass

func _on_AttackBox_body_entered(body : Node) -> void:
	if body.is_in_group('enemy'):
		#Intento de hacer que los enemigos reciban 'knockback', debe estar en la HurtBox
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


"""
IDEAS:
	·Por ahora, las colisiones parece no tener sentido, es porque la 'HitBox' actual es una prueba, a futuro será el arma que porte el jugador.
	·El knockback que da el jugador hacia los enemigos, será por la 'HurtBox' de esta manera, si el enemigo muere, podemos
	desactivar sus colisiones para que haga la animacion de morir mientras lo dejamos atrás




Intento de Fibonacci proque sí
X=0, y=1
while true:
	print(x)
	x += y
	print(y)
	y +=x

0,1,1,2,3,5,8,13
"""
