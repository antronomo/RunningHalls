extends Enemy


signal hand_died
signal hand_deleted


func _ready() -> void:
	super()
	connect("hand_died", Callable(get_node("../"), "_on_hand_died"))
	connect("hand_deleted", Callable(get_node("/root/Level0"), "_on_hand_deleted"))


func hecking_die() -> void:
	emit_signal("hand_died")
	await get_tree().create_timer(1).timeout
	emit_signal("hand_deleted")
	await get_tree().create_timer(0.1).timeout
	queue_free()
