extends Enemy


@onready var audio_stream_player : AudioStreamPlayer = $AudioStreamPlayer
@onready var core_component : CoreComponent = $CoreComponent


signal hand_died
signal hand_deleted


func _ready() -> void:
	super()
	connect("hand_died", Callable(get_node("../"), "_on_hand_died"))
	connect("hand_deleted", Callable(get_node("/root/Level0"), "_on_hand_deleted"))

func _on_sprite_2d_animation_finished() -> void:
	if anim_sprite.animation == "Attack":
		anim_sprite.animation = "Walking"
		anim_sprite.play()


func _on_CoreComponent_area_entered(area) -> void:
	anim_sprite.animation = "Attack"


func hecking_die() -> void:
	toggle_area(false)
	emit_signal("hand_died")
	audio_stream_player.playing = true


func _on_audio_stream_player_finished() -> void:
	print("audio terminado")
	emit_signal("hand_deleted")
	queue_free()


func toggle_area(boleano : bool) -> void:
	core_component.set_deferred("monitoring", boleano)   
	core_component.set_deferred("monitorable", boleano)  
	
