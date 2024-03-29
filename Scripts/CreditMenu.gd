extends Control


signal return_pressed


@onready var in_screen : bool = false


func _on_VisibilityNotifier2D_screen_entered() -> void:
	in_screen = true


func _on_VisibilityNotifier2D_screen_exited() -> void:
	in_screen = false


func _input(event) -> void:
	if in_screen and event.is_action_pressed("ui_cancel"):
		emit_signal("return_pressed")
