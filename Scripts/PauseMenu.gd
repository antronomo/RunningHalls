extends Control


@onready var anim : AnimationPlayer = $AnimationPlayer
@onready var resum_buttton : Button = $ButtonsContainer/ResumeButton
@onready var save_and_exit_buttton : Button = $ButtonsContainer/SaveButton


var callable : bool = false


signal save_time


func _ready() -> void:
	visible = false 


func game_pauser(el_booleano : bool) -> void:
	get_tree().paused = el_booleano


func _input(event : InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		toggler_pauser()


func _on_ResumeButton_pressed() -> void:
	anim.play("pause_out")


func _on_SaveButton_pressed() -> void:
	game_pauser(false)
	emit_signal("save_time")


# Queda feo cuando hace la animacion de desaparecer con los botones deshabilitados
func button_disabler(toggle : bool) -> void:
	resum_buttton.disabled = toggle
	save_and_exit_buttton.disabled = toggle


func toggler_pauser() -> void:
	if callable:
		if get_tree().paused:
			anim.play("pause_out")
		else:
			anim.play("pause_in")


func _on_AnimationPlayer_animation_started(anim_name : String) -> void:
	if anim_name == "pause_out":
		button_disabler(true)


func _on_AnimationPlayer_animation_finished(anim_name : String) -> void:
	if anim_name == "pause_out":
		button_disabler(false)


func _process(_delta) -> void:
	#if is_queued_for_deletion():
	if not callable:
		game_pauser(false)


# No conviene borrar-lo # ¿porqué?
func _on_tree_exited() -> void: 
	#print("pause menu eliminado")
	pass
