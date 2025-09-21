extends HBoxContainer

@onready var screen_settings = ConfigFileManager.load_screen_settings() #loads the screen settings into a variable, which allows read access to the properties in it

@onready var h_select: HBoxContainer = $HSelect



var framerates: PackedInt32Array = [0, 30, 60, 75, 120, 144, 240] #0 denotes unlimited fps
var selected_framerate: int = 0 #current selected fps represented as the arrays index

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	h_select.max_options = framerates.size() - 1
	h_select.option_selected = framerates.find(screen_settings.Max_FPS)
	_update_label(screen_settings.Max_FPS)
	update_selected_framerate(screen_settings.Max_FPS)
	Engine.max_fps = screen_settings.Max_FPS


func _update_label(value: int): #updates the labels display
	if value == 0:
		h_select.update_label("UNLIMITED")
	else:
		h_select.update_label(str(value))

func update_selected_framerate(value: int): #updates the currently selected framerate variable by finding if the framerate exists in the array and sets the selected frame var to the index the framerate exists at
	if framerates.has(value):
		selected_framerate = framerates.find(value)	

func _on_h_select_update_option_selected(value: int) -> void:
	selected_framerate = value
	_update_label(framerates[selected_framerate])
	ConfigsChanged.changed_screen_settings.set("Max_FPS", framerates[selected_framerate])
	pass # Replace with function body.
