extends CanvasLayer

@onready var fullscreen_button: CheckBox = $Background/HBoxContainer/VBoxContainer/FullscreenButton

var screen_settings = ConfigFileManager.load_screen_settings() #loads the screen settings into a variable, which allows read access to the properties in it

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#fullscreen_button.button_pressed = screen_settings.Fullscreen
	
	



func _on_fullscreen_button_toggled(toggled_on: bool) -> void:
	ConfigFileManager.save_screen_settings("Fullscreen", toggled_on)
	pass # Replace with function body.
