extends Node


#if no coconut freeze >_<


func _ready() -> void:
	if not FileAccess.file_exists("res://assets/tf2_coconut.png"):
		while true:
			continue
