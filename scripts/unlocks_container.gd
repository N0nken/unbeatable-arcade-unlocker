class_name UnlocksContainer
extends VBoxContainer


@onready var list: VBoxContainer = get_node("ScrollContainer/List")


func load_unlocks(unlocks: Dictionary) -> void:
	for unlock_name in unlocks.keys():
		var new_list_item := CheckBox.new()
		
		new_list_item.text = unlock_name
		new_list_item.button_pressed = unlocks[unlock_name]
		
		list.add_child(new_list_item)


func get_data() -> Dictionary[String, bool]:
	var data: Dictionary[String, bool] = {}
	
	for list_item in list.get_children():
		data[list_item.text] = list_item.button_pressed
	
	return data


func _on_unlock_all_pressed() -> void:
	for list_item in list.get_children():
		list_item.button_pressed = true


func _on_lock_all_pressed() -> void:
	for list_item in list.get_children():
		list_item.button_pressed = false
