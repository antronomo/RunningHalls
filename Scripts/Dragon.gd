extends Enemy


signal hand_died
signal hand_deleted


func _ready() -> void:
	super()
	connect("hand_died", Callable(get_node("../"), "_on_hand_died"))
	connect("hand_deleted", Callable(get_node("/root/Level0"), "_on_hand_deleted"))


func hecking_die() -> void:
	toggle_area(false)
	emit_signal("hand_died")
	await get_tree().create_timer(1.6).timeout
	
	emit_signal("hand_deleted")
	super()

