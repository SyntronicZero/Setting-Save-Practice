extends HBoxContainer
@onready var selected_label: Label = $Selected

@export var option_selected: int
@export var max_options: int


signal update_option_selected(value: int) #delcares a custom signal

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func update_label(value): #updates the labels display
	selected_label.text = str(value)
	
func update_selected(input_array: Array, value):
	if input_array.has(value):
		option_selected = input_array.find(value)

func _on_left_button_pressed() -> void:
	if option_selected > 0:
		option_selected -= 1
		emit_signal("update_option_selected", option_selected) #emits the custom signal with the argument
	pass # Replace with function body.


func _on_right_button_pressed() -> void:
	if option_selected < max_options:
		option_selected += 1
		emit_signal("update_option_selected", option_selected)
	pass # Replace with function body.
