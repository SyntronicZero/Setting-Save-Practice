extends Node

var config = ConfigFile.new() #this is our config file vaiable
const SETTINGS_SAVE_PATH = "user://settings.ini" #this is where we save the file to. Linux is /home/"user"/.local/share/godot/app_userdata/"gamename"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !FileAccess.file_exists(SETTINGS_SAVE_PATH):
		#set_value(section, key, value) section(where this value is), key(name of the value), value(whatever we want to save)
		config.set_value("keybinding", "Up", "W")
		config.set_value("keybinding", "Down", "S")
		config.set_value("keybinding", "Left", "A")
		config.set_value("keybinding", "Right", "D")
		config.set_value("keybinding", "Jump", "Space")
		config.set_value("keybinding", "Shoot", "mouse_1")
		
		config.set_value("screen", "Fullscreen", false)
		config.set_value("screen", "Width", "960")
		config.set_value("screen", "Height", "540")
		config.save(SETTINGS_SAVE_PATH)
	else: 
		config.load(SETTINGS_SAVE_PATH)
	print(OS.get_user_data_dir())
	pass # Replace with function body.

func save_screen_settings(key: String, value):
	config.set_value("screen", key, value)
	config.save(SETTINGS_SAVE_PATH)

func load_screen_settings():
	var screen_settings: Dictionary
	for key in config.get_section_keys("screen"):
		screen_settings[key] = config.get_value("screen", key)
	return screen_settings
