extends Control


@onready var cam : Camera2D = $Camera2D
@onready var parallax_background : CoreParallaxBackground = $ForestParallaxBackground


const main_cam_pos : Vector2 = Vector2.ZERO
const start_cam_pos : Vector2 = Vector2(240, 0)
const options_cam_pos : Vector2 = Vector2(-240, 0)
const credits_cam_pos : Vector2 = Vector2(0, 136) 


func _ready() -> void:
	parallax_background.parallax_speed = -16
	parallax_background.may_i_move = true


func move_camera(new_pos : Vector2, secs : float = 0.5) -> void:
	var tween : Tween = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(cam, "global_position", new_pos, secs)


# MAIN MENU FUNCTIONS----------------------------------------
func _on_MainMenu_sart_pressed() -> void:
	move_camera(start_cam_pos)


func _on_MainMenu_option_pressed() -> void:
	move_camera(options_cam_pos)


func _on_MainMenu_credit_pressed() -> void:
	move_camera(credits_cam_pos)


# START MENU FUNCTIONS-------------------------------------
func _on_StartMenu_resume_pressed() -> void:
	get_tree().change_scene_to_file("res://Level/Level0.tscn")


func _on_StartMenu_new_game_pressed() -> void:
	Globals.reset_game_data()
	get_tree().change_scene_to_file("res://Level/Level0.tscn")


func _on_StartMenu_return_pressed() -> void:
	move_camera(main_cam_pos)


# OPTIONS MENU FUNCTIONS------------------------------------
func _on_OptionsMenu_return_pressed() -> void:
	move_camera(main_cam_pos)


# CREDIT MENU FUNCTIONS-------------------------------------
func _on_CreditsMenu_return_pressed() -> void:
	move_camera(main_cam_pos)

