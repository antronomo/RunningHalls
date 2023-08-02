extends Node


func _on_AnimationPlayer_animation_finished(anim_name : String) -> void:
	if anim_name == 'Intro':
		get_tree().change_scene('res://UIs/MainMenu.tscn')