extends Control

onready var anim : AnimationPlayer = $AnimationPlayer
onready var resum_buttton : Button = $ButtonsContainer/ResumeButton
onready var save_and_exit_buttton : Button = $ButtonsContainer/SaveButton


signal save_time


func _ready() -> void:
	visible = false # Solo quiero que desaparezca nada ser instanciado, por defecto es visible para el editor


func game_pauser(el_booleano:bool) -> void:
	get_tree().paused = el_booleano


func _input(event:InputEvent) -> void:
	if event.is_action_pressed('ui_cancel'):
		if get_tree().paused:
			anim.play("pause_out")
		else:
			anim.play("pause_in")


func _on_ResumeButton_pressed() -> void:
	anim.play("pause_out")


func _on_SaveButton_pressed() -> void:
	game_pauser(false)
	emit_signal("save_time")


# Queda feo cuando hace la animacion de desaparecer con los botones deshabilitados
func button_disabler(toggle:bool) -> void:
	resum_buttton.disabled = toggle
	save_and_exit_buttton.disabled = toggle


func _on_AnimationPlayer_animation_started(anim_name:String):
	if anim_name == "pause_out":
		button_disabler(true)


func _on_AnimationPlayer_animation_finished(anim_name:String):
	if anim_name == "pause_out":
		button_disabler(false)
