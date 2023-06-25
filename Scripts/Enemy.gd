extends RigidBody2D
class_name Enemy


export var my_name : String


func hecking_die() -> void:
    queue_free()