extends OptionButton

@onready var resolution_dropdown: OptionButton = $"."


var resolutions: Dictionary = {"960 x 540": Vector2i(960, 540), 
								"1920 x 1080": Vector2i(1920, 1080),
								"2560 x 1080": Vector2i(2560, 1080)}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var screen_settings = ConfigFileManager.load_screen_settings()
	#var saved_res: String = str(screen_settings.Width) + " x " + str(screen_settings.Height)
	get_window().set_size(Vector2(screen_settings.Width, screen_settings.Height)) #sets the screen size BEFORE updating the resolution dropdown
	add_resolutions()
	#print(saved_res)
	#resolution_dropdown.select()
	#
	pass # Replace with function body.

func add_resolutions(): #adds items to the dropdown based on the resolution dictionary
	var current_res = get_window().get_size()
	var res_ID = 0
	print(current_res)
	for r in resolutions: #r is the entries in the dictionary, this cycles through each entry until its gone through all of them
		resolution_dropdown.add_item(r)
		if resolutions[r] == current_res:
			resolution_dropdown.select(res_ID)
		res_ID += 1

func save_screen_resolution(input_res):
	ConfigFileManager.save_screen_settings("Width", input_res.x)
	ConfigFileManager.save_screen_settings("Height", input_res.y)
	pass

func _on_item_selected(index: int) -> void:
	var Res_ID = resolution_dropdown.get_item_text(index)
	save_screen_resolution(resolutions[Res_ID])
	get_window().set_size(resolutions[Res_ID])
	pass # Replace with function body.
