extends CoreParallaxBackground


@onready var layer4 : ParallaxLayer = $ParallaxLayer4
@onready var layer3 : ParallaxLayer = $ParallaxLayer3
@onready var layer2 : ParallaxLayer = $ParallaxLayer2
@onready var layer1 : ParallaxLayer = $ParallaxLayer

@onready var label : Label = $ColorRect/Label


func _ready() -> void:
	var tween : Tween = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(label, "modulate", Color(1,1,1,0), 1)


func _physics_process(delta) -> void:
	if may_i_move:
		layer4.motion_offset.x += (parallax_speed - parallax_speed * 0.45) * delta
		layer3.motion_offset.x += (parallax_speed - parallax_speed * 0.35) * delta
		layer2.motion_offset.x += (parallax_speed - parallax_speed * 0.25) * delta
		layer1.motion_offset.x += parallax_speed * delta
