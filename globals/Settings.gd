extends CanvasLayer

@onready var screen_settings = ConfigFileManager.load_screen_settings() #loads the screen settings into a variable, which allows read access to the properties in it

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_center_window()
	_vsync_toggle()
	pass
	
	
#region Screen Settings
func apply_screen_settings(key: String) -> void:
	screen_settings = ConfigFileManager.load_screen_settings()
	if key == "Max_FPS":
		Engine.max_fps = screen_settings.Max_FPS
	if key == "Window_Mode":
		var mode_options: Array = [DisplayServer.WINDOW_MODE_WINDOWED, DisplayServer.WINDOW_MODE_WINDOWED, DisplayServer.WINDOW_MODE_FULLSCREEN]
		DisplayServer.window_set_mode(mode_options[screen_settings.Window_Mode])
		_update_borderless(screen_settings.Window_Mode)
	if key == "Width" or key == "Height":
		get_window().set_size(Vector2(screen_settings.Width, screen_settings.Height))
		_center_window()
	if key == "Vsync":
		_vsync_toggle()

func _vsync_toggle(): #toggles vsync
	if screen_settings.Vsync == false:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
	elif screen_settings.Vsync == true:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)

func _update_borderless(array_index: int): #updates the windows borderless
	if array_index ==1:
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
	else:
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)

func _center_window(): #centers the window on the screen
	var center_screen = DisplayServer.screen_get_position() + DisplayServer.screen_get_size() / 2
	var window_size = DisplayServer.window_get_size_with_decorations()
	get_window().set_position(center_screen - window_size / 2)
	pass

func save_changed_screen_settings():
	if ConfigsChanged.changed_screen_settings.size() > 0: #iterates through a dictionary containing settings that have been modified
		for key in ConfigsChanged.changed_screen_settings:
			ConfigFileManager.save_screen_settings(key, ConfigsChanged.changed_screen_settings[key]) #saves the modified settings to file
			apply_screen_settings(key) #applies the settings to the current session
		ConfigsChanged.changed_screen_settings.clear() #clears the 
#endregion
