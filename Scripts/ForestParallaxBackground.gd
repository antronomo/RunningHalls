extends CoreParallaxBackground


@onready var sky_parallax = $SkyParallax
@onready var clouds_parallax = $CloudsParallax
@onready var dark_bush = $DarkBush
@onready var trees_parallax = $TreesParallax
@onready var bush_parallax = $BushParallax
@onready var floorParallax = $FloorParallax



func _physics_process(delta) -> void:
	if may_i_move:
		dark_bush.motion_offset.x += (parallax_speed - parallax_speed * 0.45) * delta
		trees_parallax.motion_offset.x += (parallax_speed - parallax_speed * 0.35) * delta
		bush_parallax.motion_offset.x += (parallax_speed - parallax_speed * 0.25) * delta
		floorParallax.motion_offset.x += parallax_speed * delta
