extends Node

var config = ConfigFile.new() #this is our config file vaiable
const SETTINGS_SAVE_PATH = "user://settings.ini" #this is where we save the file to. Linux is /home/"user"/.local/share/godot/app_userdata/"gamename"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !FileAccess.file_exists(SETTINGS_SAVE_PATH): #if the config file doesnt exist, create a new one and set the following default values
		#set_value(section, key, value) section(where this value is), key(name of the value), value(whatever we want to save)
		config.set_value("keybinding", "Up", "W")
		config.set_value("keybinding", "Down", "S")
		config.set_value("keybinding", "Left", "A")
		config.set_value("keybinding", "Right", "D")
		config.set_value("keybinding", "Jump", "Space")
		config.set_value("keybinding", "Shoot", "mouse_1")
		
		#config.set_value("screen", "Fullscreen", false)
		config.set_value("screen", "Width", DisplayServer.screen_get_size().x) #gets the current screen size and auto sets the ingame resolution to it
		config.set_value("screen", "Height", DisplayServer.screen_get_size().y)
		config.set_value("screen", "Max_FPS", 0)
		config.set_value("screen", "Vsync", false)
		config.save(SETTINGS_SAVE_PATH)
		
	else: 
		config.load(SETTINGS_SAVE_PATH) #loads the config file if it exists
	print(OS.get_user_data_dir())
	pass # Replace with function body.

func save_screen_settings(key: String, value): #call this func when setting screen settings. "key" is the setting we are updating, "value" is what we are changing it to
	config.set_value("screen", key, value)
	config.save(SETTINGS_SAVE_PATH)

func load_screen_settings(): #loads screen settings
	var screen_settings: Dictionary
	for key in config.get_section_keys("screen"):
		screen_settings[key] = config.get_value("screen", key)
	return screen_settings
