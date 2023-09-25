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

	if get_parent().has_method('seeHP'):
		connect('HPStatus', get_parent(), 'seeHP')


func get_stats() -> Dictionary:
	return {
		'life' : max_life,
		'attack': attack,
		'defense' : defense,
		'crit_chance' : critical_cahnce,
		'crit_dmg' : critical_damage
	}


# func set_stats(max_life : int, atk : int, def : int, crit_chn : int, crit_dmg : int) -> void:
# 	pass


func hit() -> float:
	var dmg : float = (attack * (randi() % 50 + 75)) / 100.00

	if dmg < 1:
		dmg = 1

	if randi() % 100 + 1 <= critical_cahnce:
		dmg += (dmg * critical_damage) / 100.00
		# print('Critical')

	return dmg


func get_hurt(entring_dmg : float) -> int:
	#Se que puedo quitar variables del código y retornaría lo mismo, aún no estoy listo para ello
	# return ((((entring_dmg * 100) / defense) * entring_dmg) / 100) * -1
	var diff : int =  (entring_dmg * 100) / defense
	var hurt : int = ((diff * entring_dmg) / 100) * -1

	if hurt > 0:
		hurt = -1

	return hurt


func set_hp(new_hp : int) -> void:
	life += new_hp
	life = clamp(life, 0, max_life)
	emit_signal('HPStatus', life)


func get_hp() -> int:
	return life


func _on_CoreComponent_area_entered(area : CoreComponent) -> void:
	set_hp(get_hurt(area.hit()))

