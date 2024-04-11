extends Control


@onready var tab_container : TabContainer = $TabContainer


func _ready() -> void:
	visible = false


func _input(event : InputEvent) -> void:
	if visible and event.is_action_pressed("antonyit"):
		if tab_container.current_tab == 4:
			get_tree().change_scene_to_file("res://UIs/MenuScene.tscn")
		
		tab_container.current_tab = clamp(tab_container.current_tab + 1, 0 ,4)

