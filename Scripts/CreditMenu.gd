extends Control


@onready var rich_text_label : RichTextLabel = $PolygonMask2D/RichTextLabel
@onready var in_screen : bool = false
@onready var polygon_mask_2d : Polygon2D = $PolygonMask2D
@onready var win_size_y : int = ProjectSettings.get_setting("display/window/size/viewport_height")
@onready var tween : Tween


signal return_pressed


func _ready() -> void:
	_on_visible_on_screen_notifier_2d_screen_exited()
	rich_text_label.position.y = win_size_y


func _input(event) -> void:
	if in_screen and event.is_action_pressed("input_accept"):
		emit_signal("return_pressed")


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	in_screen = true
	polygon_mask_2d.visible = true
	move_text()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	in_screen = false
	polygon_mask_2d.visible = false
	
	if tween != null:
		tween.kill()
		
	rich_text_label.global_position.y = win_size_y


func move_text(\
new_pos : Vector2 = Vector2( rich_text_label.position.x, -rich_text_label.size.y), \
secs : float = rich_text_label.size.y / 10 \
) -> void:
	while in_screen:
		tween = create_tween()
		await tween.tween_property(rich_text_label, "position", new_pos, secs).finished
		tween.kill()
		rich_text_label.position.y = win_size_y


#func _physics_process(_delta) -> void:
	#if in_screen:
		#if rich_text_label.position.y >= -rich_text_label.size.y:
			#rich_text_label.position.y += -0.30
		#else:
			#rich_text_label.position.y = win_size_y + 10

