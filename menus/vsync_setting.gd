extends HBoxContainer

@onready var h_select: HBoxContainer = $HSelect
@onready var screen_settings = ConfigFileManager.load_screen_settings()
var selected = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset_settings_menu()
	add_to_group("Screen Settings")
	pass # Replace with function body.

func _update_label(boolean: bool):
	if boolean == true:
		h_select.update_label("Enabled")
	elif boolean == false:
		h_select.update_label("Disabled")

func _on_h_select_update_option_selected(value: int) -> void:
	selected = value
	_update_label(bool(value))
	ConfigsChanged.changed_screen_settings.set("Vsync", bool(value))
	pass # Replace with function body.

func reset_settings_menu():
	screen_settings = ConfigFileManager.load_screen_settings()
	_update_label(screen_settings.Vsync)
	h_select.option_selected = (int(screen_settings.Vsync))
