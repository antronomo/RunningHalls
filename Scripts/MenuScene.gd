extends Control


onready var anim_player : AnimationPlayer = $AnimationPlayer


signal enable_buttons


func _on_AnimationPlayer_animation_finished(anim_name:String) -> void:
	emit_signal('enable_buttons', true)


func _on_AnimationPlayer_animation_started(anim_name:String) -> void:
	emit_signal('enable_buttons', false)


func _on_Intro_IntroFinished() -> void:
	anim_player.play('Transition')
