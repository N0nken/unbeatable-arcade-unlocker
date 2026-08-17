extends CheckButton


func _init(unlock_name: String, state: bool) -> void:
	self.text = unlock_name
	self.button_pressed = state
	
	self.size_flags_horizontal = Control.SIZE_EXPAND_FILL
