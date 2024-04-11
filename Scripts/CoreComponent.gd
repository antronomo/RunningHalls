class_name CoreComponent
extends Area2D


#Si hago que los atributos del personaje dependan de otro script, 
#solo tendré que modificar este para que los actualice
@export var max_life : int = 1: get = get_max_hp, set = set_max_hp
@export var attack : int = 1
@export var defense : int = 1
@export var critical_cahnce : int
@export var critical_damage : int = 50

@export var dict_status : Dictionary = {
	"low_life" : false # low_life status become true when life is below 50% of max_life
}


# setter y getter que aparecieron al pasar el proyecto a godot4
# aún no se cómo funcionan
var life : int = 0 : get = get_hp, set = set_hp


signal HPStatus
signal status 


func _ready() -> void:
	life = max_life

	if get_parent().has_method("seeHP"):
		connect("HPStatus", Callable(get_parent(), "seeHP"))
	else:
		push_error("Cannot connect seeHP")
	
	if get_parent().has_method("update_status"):
		connect("status", Callable(get_parent(), "update_status"))
	else:
		push_error("Cannot connect update_status")


func set_dict_status(char_status : String, value : bool) -> void:
	match char_status:
		"low_life":
			dict_status.low_life = value
			emit_signal("status", "low_life", value)
		_:
			push_warning("status not found")


func get_dict_status() -> void: pass


# Se usa para que los enemigos y player puedan actualizar sus barras de vida
func get_stats() -> Dictionary:
	# print("le estats")
	return {
		"life" : max_life,
		"attack" : attack,
		"defense" : defense,
		"crit_chance" : critical_cahnce,
		"crit_dmg" : critical_damage
	}


func hit() -> float:
	var dmg : float = (attack * (randi() % 50 + 75)) / 100.00

	if dmg < 1:
		dmg = 1

	if randi() % 100 + 1 <= critical_cahnce:
		dmg += (dmg * critical_damage) / 100.00
		# print("Critical")

	return dmg


func get_hurt(entring_dmg : float) -> int:
	#print(str(life)) # esto confirma que SI colisionan unos con otros como toca
	var hurt : int = ((((entring_dmg * 100) / defense) * entring_dmg) / 100) * -1
	return hurt if hurt < -1 else -1


func set_hp(new_hp : int) -> void:
	life += new_hp
	life = clamp(life, 0, max_life)
	emit_signal("HPStatus", life)
	set_dict_status("low_life", false if life > (max_life / 2) else true)


func get_hp() -> int:
	return life


func _on_CoreComponent_area_entered(area : CoreComponent) -> void:
	set_hp(get_hurt(area.hit()))


func set_max_hp(new_max_life : int) -> void:
	max_life = new_max_life
	life = max_life


func get_max_hp() -> int:
	return max_life
