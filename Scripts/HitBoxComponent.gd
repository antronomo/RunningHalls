extends Area2D
class_name HitBoxComponent
#Tiene la estadísitca de ataque

export var attack : int
export var critical_cahnce : int 
export var critical_damage : int 

func hit() -> float:
	var dmg : float = (attack * (randi() % 50 + 75)) / 100

	if randi()%101 <= critical_cahnce:
		dmg += (dmg * critical_damage) / 100
		print('Critical')
	# var diff : float = (dmg * 100) / objective
	# return (diff * dmg) / 100
	return dmg