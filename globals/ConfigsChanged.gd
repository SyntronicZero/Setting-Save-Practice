extends Node

@onready var changed_screen_settings: Dictionary = {}
@onready var changed_audio_settings: Dictionary = {}

func revert_screen_settings():
	for n in get_tree().get_nodes_in_group("Screen Settings"):
		if n.has_method("reset_settings_menu"):
			n.reset_settings_menu()
	changed_screen_settings.clear()

func default_saved_screen_settings():
	ConfigFileManager.default_screen_settings()
	ConfigFileManager.settings_config.save(ConfigFileManager.SETTINGS_SAVE_PATH)
	for key in ConfigFileManager.load_screen_settings():
		Settings.apply_screen_settings(key)
	revert_screen_settings()
