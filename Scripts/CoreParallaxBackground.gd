class_name CoreParallaxBackground
extends ParallaxBackground


var parallax_speed : int : set = set_paraspeed
var may_i_move : bool = true # me he dado cuenta que esto es inutil...


func set_paraspeed(new_speed : int) -> void:
	parallax_speed = new_speed
	#may_i_move = true if new_speed != 0 else false
