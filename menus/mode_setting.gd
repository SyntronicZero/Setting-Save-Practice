extends HBoxContainer
@onready var screen_settings = ConfigFileManager.load_screen_settings() #loads the screen settings into a variable, which allows read access to the properties in it
@onready var h_select_2: HBoxContainer = $HSelect2
var mode_options: Array = [DisplayServer.WINDOW_MODE_WINDOWED, DisplayServer.WINDOW_MODE_WINDOWED, DisplayServer.WINDOW_MODE_FULLSCREEN] #windowed, borderless window, fullscreen

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	h_select_2.update_label(label_names(screen_settings.Window_Mode))
	h_select_2.max_options = mode_options.size() - 1
	h_select_2.option_selected = screen_settings.Window_Mode
	update_borderless(screen_settings.Window_Mode)
	DisplayServer.window_set_mode(mode_options[screen_settings.Window_Mode])
	pass # Replace with function body.

func label_names(array_index: int) -> String:
	if array_index == 0:
		return "Windowed"
	elif array_index == 1:
		return "Borderless Windowed"
	elif array_index == 2:
		return "Fullscreen"
	else:
		return ""

func update_borderless(array_index: int):
	if array_index ==1:
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
	else:
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)


func _on_h_select_2_update_option_selected(value: int) -> void:
	h_select_2.update_label(label_names(value))
	update_borderless(value)
	DisplayServer.window_set_mode(mode_options[value])
	ConfigFileManager.save_screen_settings("Window_Mode", value)
	pass # Replace with function body.
