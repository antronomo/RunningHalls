extends Enemy


func _ready() -> void:
	var random : int = randi() % 2
	$AnimatedSprite.animation = "Brown" if random == 0 else "Silver"
