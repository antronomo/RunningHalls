class_name HealthBar
extends TextureProgressBar


@onready var damage_indicator : TextureProgressBar = $DamageIndicator


func _ready() -> void: 
	damage_indicator.size = size
	damage_indicator.global_position = global_position


func _on_changed() -> void:
	damage_indicator.min_value = min_value
	damage_indicator.max_value = max_value
	damage_indicator.step = step
	#print("HelathBar min/max value changed")


func _on_value_changed(new_value : int, sec : float = 0.75) -> void:
	if damage_indicator.value > new_value:
		var tween : Tween = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(damage_indicator, "value", new_value, sec)
	else:
		damage_indicator.value = new_value

