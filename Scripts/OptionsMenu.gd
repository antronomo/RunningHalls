extends Control


signal return_pressed


@onready var tab_container : TabContainer = $TabContainer


func _on_Button1_pressed():
	tab_container.current_tab = 0


func _on_Button2_pressed():
	tab_container.current_tab = 1


func _on_Return_pressed():
	emit_signal("return_pressed")
