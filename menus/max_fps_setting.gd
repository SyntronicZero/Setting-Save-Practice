extends HBoxContainer

@onready var screen_settings = ConfigFileManager.load_screen_settings() #loads the screen settings into a variable, which allows read access to the properties in it

@onready var selected_fps_label: Label = $HSelect/SelectedFPS


var framerates: PackedInt32Array = [0, 30, 60, 75, 120, 144, 240] #0 denotes unlimited fps
var selected_framerate: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_label(selected_fps_label, screen_settings.Max_FPS)
	update_selected_framerate(screen_settings.Max_FPS)
	Engine.max_fps = screen_settings.Max_FPS
	pass # Replace with function body.

func _process(delta: float) -> void:
	print(Engine.get_frames_per_second())

func update_label(label: Label, value):
	if value == 0:
		label.text = "UNLIMITED"
	else:
		label.text = str(value)

func update_selected_framerate(value: int):
	if framerates.has(value):
		selected_framerate = framerates.find(value)
	

func _on_left_button_pressed() -> void:
	if selected_framerate > 0:
		selected_framerate -= 1
		update_label(selected_fps_label, framerates[selected_framerate])
		ConfigFileManager.save_screen_settings("Max_FPS", framerates[selected_framerate])
		Engine.max_fps = framerates[selected_framerate]
	pass # Replace with function body.


func _on_right_button_pressed() -> void:
	if selected_framerate < (framerates.size() - 1):
		selected_framerate += 1
		update_label(selected_fps_label, framerates[selected_framerate])
		ConfigFileManager.save_screen_settings("Max_FPS", framerates[selected_framerate])
		Engine.max_fps = framerates[selected_framerate]
	pass # Replace with function body.
