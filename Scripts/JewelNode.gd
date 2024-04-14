class_name JewelNode
extends Node


@onready var sprite : Sprite2D = $Sprite2D


@export var recurso : JewelResource


func _ready() -> void: 
	if recurso:
		sprite.texture = recurso.texture


func _enter_tree() -> void: pass

