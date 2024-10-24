class_name MainMenu
extends Control
@onready var playbutton = $MarginContainer/HBoxContainer/VBoxContainer/playbutton as Button
@onready var player = $Player
@onready var save_load_manager = $SaveLoadManager
@onready var options_menu = $options_menu as OptionsMenu
@onready var margin_container = $MarginContainer as MarginContainer
@onready var start_level = preload("res://scenes/maintest.tscn") as PackedScene
var playerdata = PlayerData.new()





# Changes scene to main scene
func _on_play_pressed():
	get_tree().change_scene_to_packed(start_level)


# Quits the game
func _on_quit_pressed():
	get_tree().quit()


# Opens the options menu
func _on_options_pressed():
	get_tree().change_scene_to_file("res://scenes/options/scenes/options_menu.tscn")

