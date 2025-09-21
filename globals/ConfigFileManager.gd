extends Node
#ATTENTION: this is a global settings_config file. It must be autoloaded
var settings_config = ConfigFile.new() #this is our config file vaiable
var default_config = ConfigFile.new()
var keybindings_config = ConfigFile.new() #this is the keybindings config
const SETTINGS_SAVE_PATH = "user://settings.ini" #this is where we save the file to. Linux is /home/"user"/.local/share/godot/app_userdata/"gamename"
const DEFAULT_SETTINGS_PATH = "res://defaults/default_settings.ini"

const KEYBINDING_SAVE_PATH = "user://keybindings.ini"
const DEFAULT_KEYBINDINGS_PATH = "res://defaults/default_keybindings.ini"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#this is for the settings file, stores settings for screen, fps, volume, etc.
	if !FileAccess.file_exists(SETTINGS_SAVE_PATH): #if the settings_config file doesnt exist, create a new one and set the following default values
		#set_value(section, key, value) section(where this value is), key(name of the value), value(whatever we want to save)
		default_screen_settings()
		settings_config.save(SETTINGS_SAVE_PATH)
		settings_config.save(DEFAULT_SETTINGS_PATH)
		
	else: 
		settings_config.load(SETTINGS_SAVE_PATH) #loads the settings_config file if it exists
		default_config.load(DEFAULT_SETTINGS_PATH)
	#this is for keybindings, stores the various keybindings
	if !FileAccess.file_exists(KEYBINDING_SAVE_PATH):
		#keyboard bindings
		keybindings_config.set_value("keyboard", "Up", "W")
		keybindings_config.set_value("keyboard", "Down", "S")
		keybindings_config.set_value("keyboard", "Left", "A")
		keybindings_config.set_value("keyboard", "Right", "D")
		keybindings_config.set_value("keyboard", "Jump", "Space")
		keybindings_config.set_value("keyboard", "Shoot", "mouse_1")
		#controller bindings
		keybindings_config.set_value("controller", "placeholder", "x")
		keybindings_config.save(KEYBINDING_SAVE_PATH)
		keybindings_config.save(DEFAULT_KEYBINDINGS_PATH)
	else:
		keybindings_config.load(DEFAULT_KEYBINDINGS_PATH)
	print(OS.get_user_data_dir())
	pass # Replace with function body.

func save_screen_settings(key: String, value): #call this func when setting screen settings. "key" is the setting we are updating, "value" is what we are changing it to
	settings_config.set_value("screen", key, value)
	settings_config.save(SETTINGS_SAVE_PATH)

func load_screen_settings(): #loads screen settings
	var screen_settings: Dictionary
	if settings_config.has_section("screen"):
		for key in settings_config.get_section_keys("screen"):
			screen_settings[key] = settings_config.get_value("screen", key)
	return screen_settings

func default_screen_settings():
	#set_value(section, key, value) section(where this value is), key(name of the value), value(whatever we want to save)
	settings_config.set_value("screen", "Width", DisplayServer.screen_get_size().x) #gets the current screen size and auto sets the ingame resolution to it
	settings_config.set_value("screen", "Height", DisplayServer.screen_get_size().y)
	settings_config.set_value("screen", "Window_Mode", 0)
	settings_config.set_value("screen", "Max_FPS", 0)
	settings_config.set_value("screen", "Vsync", false)
