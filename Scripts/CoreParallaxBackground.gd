extends ParallaxBackground
class_name CoreParallaxBackground


var parallax_speed : int = 0 setget set_paraspeed, get_paraspeed
var may_i_move : bool = false


func set_paraspeed(new_speed : int) -> void:
	parallax_speed = new_speed

	may_i_move = true if new_speed != 0 else false


func get_paraspeed() -> int: 
	return parallax_speed
