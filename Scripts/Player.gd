extends Node2D


@onready var core_component : CoreComponent = $CoreComponent
@onready var anim_player : AnimationPlayer = $AnimationPlayer
@onready var audio_stream_player = $AudioStreamPlayer


@export var my_name : String = 'player'


var dict_status : Dictionary = {
	"low_life" : false
}


signal updateHP
signal morido


func _ready() -> void:
	connect('updateHP', Callable(get_node('../GUI'), 'update_helath_bar'))
	connect('morido', Callable(get_node('../'), 'finish_game'))


func seeHP(hp : int) -> void:
	emit_signal('updateHP', hp)

	if hp <= 0:
		going_to_die()


# Seguramente lo mueva a PlayerStats.gd
func going_to_heal() -> void:
	core_component.revive_player()
	core_component.set_hp(999999999)


# Por ahora no tiene uso, llamado desde playerstats
func update_status(_status : String, _value : bool) -> void: pass 

# Esto es cuando el jugador colisiona con un enemigo, para empujar-lo
# Lo voy a cambiar para que solo lo empuje al aturdirlo o al hacer crítico.
func _on_CoreComponent_body_entered(_body : Enemy) -> void: pass
	# print('empujacion')
	# body.apply_central_impulse(Vector2(randi() % 100 + 51, - randi() % 175 - 126))


func going_to_die() -> void:
	anim_player.play('dying')
	emit_signal('morido')
	
	#await get_tree().create_timer(1).timeout
	#disconnect('updateHP', Callable(get_node('../GUI'), 'update_helath_bar'))
	#disconnect('morido', Callable(get_node('../'), 'finish_game'))


func walk_anim() -> void: 
	anim_player.play("walking")


func stop_anim() -> void:
	anim_player.pause()


func blip() -> void:
	audio_stream_player.pitch_scale = randf_range(0.8, 1.2)
	audio_stream_player.play()


func _on_animation_player_animation_finished(anim_name : String) -> void:
	match anim_name:
		"dying":
			anim_player.play("vanishing")
			
		_:
			pass

