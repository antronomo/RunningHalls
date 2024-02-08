extends Control


signal return_pressed


@onready var in_screen : bool = false


func _on_VisibilityNotifier2D_screen_entered():
	in_screen = true


func _on_VisibilityNotifier2D_screen_exited():
	in_screen = false


func _input(event) -> void:
	if in_screen && event.is_action_pressed("ui_cancel"):
		emit_signal("return_pressed")
