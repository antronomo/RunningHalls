extends Control


onready var cam : Camera2D = $Camera2D


var main_cam_pos : Vector2 = Vector2(120, 67)
var start_cam_pos : Vector2 = Vector2(360, 67)
var options_cam_pos : Vector2 = Vector2(-120, 67)
var credits_cam_pos : Vector2 = Vector2(120, 203)


func move_camera(new_pos:Vector2) -> void:
	var tween : SceneTreeTween = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(cam, "global_position", new_pos, 0.50)


# MAIN MENU FUNCTIONS----------------------------------------
func _on_MainMenu_sart_pressed() -> void:
	move_camera(start_cam_pos)


func _on_MainMenu_option_pressed() -> void:
	move_camera(options_cam_pos)


func _on_MainMenu_credit_pressed() -> void:
	move_camera(credits_cam_pos)


# START MENU FUNCTIONS-------------------------------------
func _on_StartMenu_resume_pressed() -> void:
	get_tree().change_scene('res://Level/Level0.tscn')


func _on_StartMenu_new_game_pressed() -> void:
	Globals.reset_game_data()
	get_tree().change_scene('res://Level/Level0.tscn')


func _on_StartMenu_return_pressed() -> void:
	move_camera(main_cam_pos)


# OPTIONS MENU FUNCTIONS------------------------------------
func _on_OptionsMenu_return_pressed() -> void:
	move_camera(main_cam_pos)


# CREDIT MENU FUNCTIONS-------------------------------------
func _on_CreditsMenu_return_pressed() -> void:
	move_camera(main_cam_pos)
