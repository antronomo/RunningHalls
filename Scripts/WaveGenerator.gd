extends Node

# regular enemies
const dark_wizard : PackedScene = preload("res://Enemies/DarkWizard.tscn")
const humacean : PackedScene = preload("res://Enemies/Humacean.tscn")
const ghost : PackedScene = preload("res://Enemies/Ghost.tscn")
const bat : PackedScene = preload("res://Enemies/Bat.tscn")
const rat : PackedScene = preload("res://Enemies/Rat.tscn")
const spider : PackedScene = preload("res://Enemies/Spider.tscn")
const vampire : PackedScene = preload("res://Enemies/Vampire.tscn")

# boss enemies
const a_hand : PackedScene = preload("res://Enemies/a_hand.tscn")
const dragon : PackedScene = preload("res://Enemies/Dragon.tscn")


const enemyGroupsList : Array = [
	[bat, rat, spider],
	[humacean, ghost, dark_wizard],
	[humacean, dark_wizard, vampire],
	[bat, dark_wizard, vampire]
]

# No invocar el dragón, no está bien iplementado
const bossesList : Array = [a_hand, dragon]


@onready var enemy_group_size : int = enemyGroupsList.size()


var new_wave : Array


func get_new_wave() -> Array:
	var enemy_list = enemyGroupsList[randi() % enemy_group_size]
	var wave_length : int = randi() % 3 + 5
	
	new_wave = [
		[enemy_list[0]],
		[enemy_list[0], enemy_list[0]],
		[enemy_list[0], enemy_list[1], enemy_list[1]],
		[enemy_list[1], enemy_list[2], enemy_list[2]],
		[enemy_list[2]]
	]

	if wave_length >= 6:
		new_wave.append_array([[enemy_list[0], enemy_list[1], enemy_list[2], enemy_list[2]]])

		if wave_length == 7:
			new_wave.append_array([[enemy_list[randi() % 3]]])

	# print(str(wave_num), str(wave_list))
	return new_wave
	
	
func get_boss() -> Array:
	return [[dragon]]
