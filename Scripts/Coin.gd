extends CPUParticles2D

const golden_coin : String = "res://Assets/img/GoldCoin.png"
const silver_coin : String = "res://Assets/img/SilverCoin.png"
const bronce_coin : String = "res://Assets/img/BronceCoin.png"


var coin_list : Array = [
	golden_coin,
	silver_coin,
	bronce_coin
]


func _ready() -> void:
	emitting = true


func _on_Timer_timeout() -> void:
	queue_free()
