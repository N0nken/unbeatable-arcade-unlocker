class_name StatusLabel
extends Label


@export var timeout_s: float = 5 ## timeout in seconds


func show_status(status: String) -> void:
	self.text = status
	
	await get_tree().create_timer(timeout_s).timeout
	
	self.text = ""
