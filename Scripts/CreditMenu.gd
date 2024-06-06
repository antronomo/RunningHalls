extends Control


@onready var rich_text_label : RichTextLabel = $PolygonMask2D/RichTextLabel
@onready var in_screen : bool = false
@onready var polygon_mask_2d : Polygon2D = $PolygonMask2D


signal return_pressed


const credit_window_size : Vector2 = Vector2(224, 120)


func _ready() -> void:
	_on_visible_on_screen_notifier_2d_screen_exited()


func _input(event) -> void:
	if in_screen and event.is_action_pressed("input_accept"):
		emit_signal("return_pressed")


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	in_screen = true
	polygon_mask_2d.visible = true
	#print(str(in_screen))


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	in_screen = false
	polygon_mask_2d.visible = false
	rich_text_label.position.y = credit_window_size.y + 10
	#print(str(in_screen))


func _process(_delta) -> void:
	if in_screen:
		if rich_text_label.position.y >= -rich_text_label.size.y:
			rich_text_label.position.y += -0.5
		else:
			rich_text_label.position.y = credit_window_size.y + 10

