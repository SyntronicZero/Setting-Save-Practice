extends CanvasLayer

var screen_settings = ConfigFileManager.load_screen_settings() #loads the screen settings into a variable, which allows read access to the properties in it

signal apply_settings()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#fullscreen_button.button_pressed = screen_settings.Fullscreen
	
	


func _on_apply_settings_pressed() -> void:
	print(ConfigsChanged.changed_screen_settings)
	if ConfigsChanged.changed_screen_settings.size() > 0:
		for key in ConfigsChanged.changed_screen_settings:
			ConfigFileManager.save_screen_settings(key, ConfigsChanged.changed_screen_settings[key])
			print(key)
	apply_settings.emit()
	pass # Replace with function body.
