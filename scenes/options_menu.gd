extends Control
class_name OptionsMenu

@onready var exit_button = $MarginContainer/VBoxContainer/Button as Button

signal exit_options_menu

func _ready():
	if exit_button:
		exit_button.connect("button_down", self, "on_exit_pressed")
	else:
		print("Exit button not found!")
	set_process(false)

func on_exit_pressed() -> void:
	exit_options_menu.emit()
	set_process(false)
