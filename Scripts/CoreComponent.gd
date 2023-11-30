extends Area2D
class_name CoreComponent


#Si hago que los atributos del personaje dependan de otro script, solo tendré que modificar este para que los actualice
export var max_life : int = 1 setget set_max_hp, get_max_hp
export var attack : int = 1
export var defense : int = 1
export var critical_cahnce : int
export var critical_damage : int = 50


var life : int = 0 setget set_hp, get_hp


signal HPStatus


func _ready() -> void:
	life = max_life

	if get_parent().has_method('seeHP'):
		connect('HPStatus', get_parent(), 'seeHP')


# No se usa, no me acuerdo porqué existe esta función
func get_stats() -> Dictionary:
	#print('le estats')
	return {
		'life' : max_life,
		'attack' : attack,
		'defense' : defense,
		'crit_chance' : critical_cahnce,
		'crit_dmg' : critical_damage
	}


func hit() -> float:
	var dmg : float = (attack * (randi() % 50 + 75)) / 100.00

	if dmg < 1:
		dmg = 1

	if randi() % 100 + 1 <= critical_cahnce:
		dmg += (dmg * critical_damage) / 100.00
		# print('Critical')

	return dmg


func get_hurt(entring_dmg : float) -> int:
	# int() para quitar la advertencia "float to int"
	var hurt : int = int(((((entring_dmg * 100) / defense) * entring_dmg) / 100) * -1)
	return hurt if hurt < -1 else -1


func set_hp(new_hp : int) -> void:
	life += new_hp
	life = int(clamp(life, 0, max_life)) # int() para quitar "float to int" advertencia
	emit_signal('HPStatus', life)


func get_hp() -> int:
	return life


func _on_CoreComponent_area_entered(area : CoreComponent) -> void:
	set_hp(get_hurt(area.hit()))


func set_max_hp(new_max_life : int) -> void:
	max_life = new_max_life
	life = max_life


func get_max_hp() -> int:
	return max_life
