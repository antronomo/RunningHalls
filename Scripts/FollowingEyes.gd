extends AnimatedSprite2D


func _on_area_2d_area_entered(_area : Area2D) -> void:
	play("default")


"""
no funciona como debería, la animacion salta con cualquier enemigo...
tampoco es prioridad
no, no tiene el 'autoplay on load'
"""
