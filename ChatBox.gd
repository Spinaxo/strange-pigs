extends Control

@onready var chat_log = $VBoxContainer/RichTextLabel
@onready var input_label = $VBoxContainer/HBoxContainer/Label
@onready var input_field = $VBoxContainer/HBoxContainer/LineEdit


func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ENTER:
			input_field
