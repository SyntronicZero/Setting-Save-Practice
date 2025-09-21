extends HBoxContainer
@onready var settings: CanvasLayer = $"../../.."

func _on_revert_button_pressed() -> void:
	ConfigsChanged.revert_screen_settings()
	pass # Replace with function body.


func _on_apply_button_pressed() -> void:
	Settings.save_changed_screen_settings()
	pass # Replace with function body.


func _on_defaults_button_pressed() -> void:
	ConfigsChanged.default_saved_screen_settings()
	pass # Replace with function body.
