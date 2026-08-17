extends Control


@export var tabs: PanelContainer
@export var file_dialog: FileDialog
@export var light_mode_vfx: ColorRect

@export var selected_folder_filepath_label: Label
@export var status_label: StatusLabel

@export var song_unlocks_tab: UnlocksContainer
@export var character_unlocks_tab: UnlocksContainer
@export var menu_palette_unlocks_tab: UnlocksContainer
@export var difficulty_unlocks_tab: UnlocksContainer
@export var stage_unlocks_tab: UnlocksContainer



var file_loaded: bool = false

var profile_config: Dictionary = {"TopTitle":"", "MiddleTitle":"", "BottomTitle":"", "BadgeTitle":""}
var title_unlocks: Dictionary


func _on_select_file_pressed() -> void:
	file_dialog.popup_file_dialog()


func _on_save_pressed() -> void:
	if not file_loaded:
		status_label.show_status("Load a file first!")
		return
	
	file_dialog.popup_file_dialog()


func load_save(filepath: String) -> void:
	var save_file: FileAccess = FileAccess.open(filepath, FileAccess.READ)
	
	if not save_file:
		status_label.show_status("Failed to load file!")
		return
	
	var text_content: String = save_file.get_as_text()
	var data: Dictionary = JSON.parse_string(text_content)
	
	var song_unlocks: Dictionary = JSON.parse_string(data["songUnlocksSave"])["Data"]
	var difficulty_unlocks: Dictionary = JSON.parse_string(data["difficultyUnlocksSave"])["Data"]
	var character_unlocks: Dictionary = JSON.parse_string(data["characterUnlocksSave"])["Data"]
	var menu_palette_unlocks: Dictionary = JSON.parse_string(data["menuPaletteUnlocksSave"])["Data"]
	var stage_unlocks: Dictionary = JSON.parse_string(data["rhythmSceneUnlocksSave"])["Data"]
	
	title_unlocks = JSON.parse_string(data["titleUnlocksSave"])["Data"]
	profile_config = data["yourProfileConfig"]
	
	song_unlocks_tab.load_unlocks(song_unlocks)
	character_unlocks_tab.load_unlocks(character_unlocks)
	menu_palette_unlocks_tab.load_unlocks(menu_palette_unlocks)
	difficulty_unlocks_tab.load_unlocks(difficulty_unlocks)
	stage_unlocks_tab.load_unlocks(stage_unlocks)
	
	file_loaded = true
	
	status_label.show_status("Loaded File!")
	selected_folder_filepath_label.text = filepath
	


func store_save(filepath: String) -> void:
	var save_file: FileAccess = FileAccess.open(filepath, FileAccess.WRITE)
	
	var song_unlocks: Dictionary = song_unlocks_tab.get_data()
	var difficulty_unlocks: Dictionary = difficulty_unlocks_tab.get_data()
	var character_unlocks: Dictionary = character_unlocks_tab.get_data()
	var menu_palette_unlocks: Dictionary = menu_palette_unlocks_tab.get_data()
	var stage_unlocks: Dictionary = stage_unlocks_tab.get_data()
	
	var stringified_song_unlocks: String = _stringify_save_dict(song_unlocks)
	var stringified_difficulty_unlocks: String = _stringify_save_dict(difficulty_unlocks)
	var stringified_character_unlocks: String = _stringify_save_dict(character_unlocks)
	var stringified_menu_palette_unlocks: String = _stringify_save_dict(menu_palette_unlocks)
	var stringified_stage_unlocks: String = _stringify_save_dict(stage_unlocks)
	
	var stringified_title_unlocks: String = _stringify_save_dict(title_unlocks)
	var stringified_profile_config: String = JSON.stringify(profile_config)
	
	var stringified_data: String = "{"
	
	stringified_data += '"songUnlocksSave":"' + stringified_song_unlocks + '",'
	stringified_data += '"difficultyUnlocksSave":"' + stringified_difficulty_unlocks + '",'
	stringified_data += '"titleUnlocksSave":"' + stringified_title_unlocks + '",'
	stringified_data += '"characterUnlocksSave":"' + stringified_character_unlocks + '",'
	stringified_data += '"menuPaletteUnlocksSave":"' + stringified_menu_palette_unlocks + '",'
	stringified_data += '"rhythmSceneUnlocksSave":"' + stringified_stage_unlocks + '",'
	
	stringified_data += '"yourProfileConfig":' + stringified_profile_config + ','
	stringified_data += '"queuedUnlocks":[]'
	
	stringified_data += "}"
	
	save_file.store_string(stringified_data)
	
	status_label.show_status("Saved File!")


func _stringify_save_dict(dict: Dictionary) -> String:
	var stringified_save_dict: String = '{\\"Data\\":{'
	
	var i: int = 1
	for key in dict.keys():
		stringified_save_dict += '\\"' + key + '\\":' + str(dict[key])
		
		if i < dict.keys().size():
			stringified_save_dict += ","
		
		i += 1
	
	stringified_save_dict += "}}"
	
	return stringified_save_dict


func _on_file_dialog_file_selected(path: String) -> void:
	if file_loaded:
		store_save(path)
	else:
		load_save(path)


func _on_light_mode_toggle_toggled(toggled_on: bool) -> void:
	if toggled_on:
		light_mode_vfx.material.set_shader_parameter("enabled", true)
		light_mode_vfx.visible = true
	else:
		light_mode_vfx.material.set_shader_parameter("enabled", false)
		light_mode_vfx.visible = false


func _on_songs_tab_pressed() -> void:
	tabs.open_tab(tabs.Tab.SONGS)


func _on_difficulties_tab_pressed() -> void:
	tabs.open_tab(tabs.Tab.DIFFICULTIES)


func _on_characters_tab_pressed() -> void:
	tabs.open_tab(tabs.Tab.CHARACTERS)


func _on_menu_palettes_tab_pressed() -> void:
	tabs.open_tab(tabs.Tab.MENU_PALETTES)


func _on_stages_tab_pressed() -> void:
	tabs.open_tab(tabs.Tab.STAGES)
