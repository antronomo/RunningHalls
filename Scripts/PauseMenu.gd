extends Control

@onready var anim : AnimationPlayer = $AnimationPlayer
@onready var color_rect : ColorRect = $ColorRect
@onready var label : Label = $Label
@onready var resum_buttton : Button = $ButtonsContainer/ResumeButton
@onready var options_button : Button = $ButtonsContainer/OptionsButton
@onready var save_and_exit_buttton : Button = $ButtonsContainer/SaveButton
@onready var button_fx : AudioStreamPlayer = $ButtonFX

var callable : bool = false

signal pause_option_pressed
signal save_time
signal hidded

func _ready() -> void:
	visible = false


func game_pauser(el_booleano : bool) -> void:
	get_tree().paused = el_booleano


func _input(event : InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		toggler_pauser()


func toggler_pauser() -> void:
	if callable:
		if get_tree().paused:
			anim.play("pause_out")
		else:
			button_fx.play()
			anim.play("pause_in")


func _on_ResumeButton_pressed() -> void:
	button_fx.play()
	anim.play("pause_out")


func _on_options_button_pressed() -> void:
	button_fx.play()
	options_button.release_focus()
	emit_signal("pause_option_pressed")


func _on_SaveButton_pressed() -> void:
	button_fx.play()
	game_pauser(false)
	emit_signal("save_time")


# Queda feo cuando hace la animacion de desaparecer con los botones deshabilitados
func button_disabler(toggle : bool) -> void:
	resum_buttton.disabled = toggle
	save_and_exit_buttton.disabled = toggle
	options_button.disabled = toggle


func _on_AnimationPlayer_animation_started(anim_name : String) -> void:
	if anim_name == "pause_out":
		button_disabler(true)


func _on_AnimationPlayer_animation_finished(anim_name : String) -> void:
	if anim_name == "pause_out":
		button_disabler(false)
		emit_signal("hidded")


func _process(_delta) -> void:
	#if is_queued_for_deletion():
	if not callable:
		game_pauser(false)
