extends Enemy


func _on_CoreComponent_NoHP() -> void:
    print(my_name + ' died')
    going_to_die()


func going_to_die() -> void:
	hecking_die()