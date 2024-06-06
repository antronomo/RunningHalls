extends CoreParallaxBackground


@onready var parallax_layer = $ParallaxLayer


signal transitiontime


func _ready() -> void:
	connect("transitiontime", Callable(get_node("../"), "transition_time"))


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	emit_signal("transitiontime")


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _physics_process(delta) -> void:
	if may_i_move:
		parallax_layer.motion_offset.x += parallax_speed * delta

