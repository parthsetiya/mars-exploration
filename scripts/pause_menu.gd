extends Control
@onready var start_level = preload("res://scenes/maintest.tscn") as PackedScene
var playerdata = PlayerData.new()

# Resume the game
func _on_resume_pressed():
	get_tree().change_scene_to_file("res://scenes/maintest.tscn")
	Engine.time_scale =  1


# change the scene to the settings scene
func _on_settings_pressed():
	get_tree().change_scene_to_file("res://scenes/options/options_menu.tscn")


# Quits back to the main menu
func _on_quit_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")


