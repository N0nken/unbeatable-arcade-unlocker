extends PanelContainer


enum Tab {
	SONGS,
	TITLES,
	CHARACTERS,
	MENU_PALETTES,
	DIFFICULTIES,
	STAGES,
}


@onready var songs_tab: UnlocksContainer = get_node("SongUnlocks")
@onready var difficulties_tab: UnlocksContainer = get_node("DifficultyUnlocks")
@onready var characters_tab: UnlocksContainer = get_node("CharacterUnlocks")
@onready var menu_palettes_tab: UnlocksContainer = get_node("MenuPaletteUnlocks")
@onready var stages_tab: UnlocksContainer = get_node("StageUnlocks")

@onready var all_tabs: Array[UnlocksContainer] = [
	songs_tab,
	characters_tab,
	menu_palettes_tab,
	difficulties_tab,
	stages_tab
]


func open_tab(tab: Tab) -> void:
	_hide_all()
	
	match tab:
		Tab.SONGS:
			songs_tab.visible = true
		Tab.CHARACTERS:
			characters_tab.visible = true
		Tab.MENU_PALETTES:
			menu_palettes_tab.visible = true
		Tab.DIFFICULTIES:
			difficulties_tab.visible = true
		Tab.STAGES:
			stages_tab.visible = true


func _hide_all() -> void:
	for tab in all_tabs:
		tab.visible = false
