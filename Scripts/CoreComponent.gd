extends Area2D
class_name CoreComponent


export var max_life : int = 1
export var attack : int = 1
export var defense : int = 1
export var critical_cahnce : int
export var critical_damage : int = 50


var life : int = 0 setget set_hp, get_hp


signal HPStatus


func _ready() -> void:
	life = max_life

	if get_parent():
		connect('HPStatus', get_parent(), 'seeHP')


func get_stats() -> Dictionary:
	var stats : Dictionary = {
		'life' : max_life,
		'attack': attack,
		'defense' : defense,
		'crit_chance' : critical_cahnce,
		'crit_dmg' : critical_damage
	}

	return stats


func hit() -> float:
	var dmg : float = (attack * (randi() % 50 + 75)) / 100.00

	if dmg <= 1:
		dmg = 1

	if randi() % 101 <= critical_cahnce:
		dmg += (dmg * critical_damage) / 100.00
		print('Critical')

	return dmg


func get_hurt(entring_dmg : float) -> float: 
	var diff : float =  (entring_dmg * 100) / defense
	var hurt : float = (((diff * entring_dmg) / 100) * -1)

	return hurt


func set_hp(new_hp : int) -> void:
	life += new_hp
	
	life = clamp(life, 0, max_life)

	emit_signal('HPStatus', life)


func get_hp() -> int:
	return life


func _on_CoreComponent_area_entered(area : CoreComponent) -> void:
	# print('i am ' + get_parent().my_name)

	var le_dmg = area.hit()
	# print('paso 1 ' + str(le_dmg))

	var le_hurt = get_hurt(le_dmg)
	# print('paso 2 ' + str(le_hurt))
	set_hp(le_hurt)

	var le_hp = get_hp()
	# print(get_parent().my_name + 'hp ' + str(le_hp))

	# print('finished')

