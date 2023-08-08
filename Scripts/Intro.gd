extends Node2D


signal IntroFinished


func _on_AnimationPlayer_animation_finished(anim_name:String) -> void:
	if anim_name == 'Intro':
		emit_signal('IntroFinished')


func play_intro() -> void:
	$AnimationPlayer.play('Intro')