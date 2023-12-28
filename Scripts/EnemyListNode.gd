extends Node


const dark_wizard : PackedScene = preload("res://Enemies/DarkWizard.tscn")
const humacean : PackedScene = preload("res://Enemies/Humacean.tscn")
const ghost : PackedScene = preload("res://Enemies/Ghost.tscn")
const bat : PackedScene = preload("res://Enemies/Bat.tscn")
const rat : PackedScene = preload("res://Enemies/Rat.tscn")
const spider : PackedScene = preload("res://Enemies/Spider.tscn")
const vampire : PackedScene = preload("res://Enemies/Vampire.tscn")

const enemyGroupsList : Array = [
	[bat, rat, spider],
	[humacean, ghost, dark_wizard],
	[humacean, dark_wizard, vampire],
	[bat, dark_wizard, vampire]
]

# const bossesList : Array = []


func get_enemy_group() -> Array:
	var num = randi() % enemyGroupsList.size()
	return enemyGroupsList[num]
