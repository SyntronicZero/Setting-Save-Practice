extends Control

@onready var fullscreen_button: CheckBox = $Background/HBoxContainer/VBoxContainer/FullscreenButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var screen_settings = ConfigFileManager.load_screen_settings()
	fullscreen_button.button_pressed = screen_settings.Fullscreen
	
	



func _on_fullscreen_button_toggled(toggled_on: bool) -> void:
	ConfigFileManager.save_screen_settings("Fullscreen", toggled_on)
	pass # Replace with function body.
