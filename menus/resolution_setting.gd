extends HBoxContainer

@onready var screen_settings = ConfigFileManager.load_screen_settings() #loads the screen settings into a variable, which allows read access to the properties in it

@onready var resolution_dropdown: OptionButton = $ResolutionDropdown

#dictionary of preset resolution options. New options can be easily added just by adding to this dict
var resolutions: Dictionary = {"960 x 540": Vector2i(960, 540), 
								"1280 x 720": Vector2i(1280, 720),
								"1920 x 1080": Vector2i(1920, 1080),
								"2560 x 1080": Vector2i(2560, 1080),
								"2560 x 1440": Vector2i(2560, 1440),
								"3440 x 1440": Vector2i(3440, 1440),
								"3840 x 2160": Vector2i(3840, 2160)}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_window().set_size(Vector2(screen_settings.Width, screen_settings.Height)) #sets the screen size from config BEFORE updating the resolution dropdown
	add_resolutions()
	Settings._center_window()
	add_to_group("Screen Settings")

func add_resolutions(): #adds items to the dropdown based on the resolution dictionary
	var current_res = get_window().get_size()
	var res_ID = 0
	for r in resolutions: #r is the entries in the dictionary, this cycles through each entry until its gone through all of them
		resolution_dropdown.add_item(r)
		if resolutions[r] == current_res: #detects if the current screen res is an available option in the drop down and sets the dropdown to it
			resolution_dropdown.select(res_ID)
		res_ID += 1

func reset_settings_menu(): #resets the setting when back to the player saved option when called
	screen_settings = ConfigFileManager.load_screen_settings()
	var saved_screen_res: Vector2i = Vector2i(screen_settings.Width, screen_settings.Height)
	var res_ID = 0
	for r in resolutions:
		if resolutions[r] == saved_screen_res:
			resolution_dropdown.select(res_ID)
		res_ID += 1

func save_screen_resolution(input_res: Vector2i): #converts Vector2 into the savable format used in the config
	ConfigFileManager.save_screen_settings("Width", input_res.x)
	ConfigFileManager.save_screen_settings("Height", input_res.y)
	pass

func _on_resolution_dropdown_item_selected(index: int) -> void:  #updates screen resolution based on what one was selected in the dropdown
	var Res_ID = resolution_dropdown.get_item_text(index)
	ConfigsChanged.changed_screen_settings.set("Width", resolutions[Res_ID].x)
	ConfigsChanged.changed_screen_settings.set("Height", resolutions[Res_ID].y)
	pass # Replace with function body.
