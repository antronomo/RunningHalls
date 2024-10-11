extends Control


@onready var tab_container : TabContainer = $TabContainer
@onready var stats_label :Label = $TabContainer/StatsTab/StatsLabel


var max_atabs : int
var current_game : Dictionary


func _ready() -> void:
	visible = false
	tab_container.current_tab = 0
	max_atabs = tab_container.get_tab_count() - 1


func _input(event : InputEvent) -> void:
	if visible and event.is_action_pressed("input_accept"):
		if tab_container.current_tab == max_atabs:
			Globals.reset_game_data()
			get_tree().change_scene_to_file("res://UIs/MenuScene.tscn")
			return
		
		tab_container.current_tab = clamp(tab_container.current_tab + 1, 0, max_atabs)


func _on_visibility_changed() -> void:
	current_game = Globals.current_game.duplicate()
	if visible == true:
		await get_tree().create_timer(0.1).timeout # Solucion de mierda para mal timing
		stats_label.text = "attemps: " + str(current_game.game_info.tries) + "\n" \
		 + "gold obtained: " + str(current_game.game_info.total_gold)
