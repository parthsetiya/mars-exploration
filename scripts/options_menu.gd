extends Control
class_name OptionsMenu
@onready var exit_button = $MarginContainer/VBoxContainer/Exit_Button as Button
signal exit_options_menu


# Exits back to the main menu of the game
func _on_exit_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

