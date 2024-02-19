extends Control

@onready var start_level = preload("res://scenes/main.tscn") as PackedScene



func _on_resume_pressed():
	#get_tree().change_scene_to_packed(start_level)
	hide()
	Engine.time_scale =  1


func _on_settings_pressed():
	get_tree().change_scene_to_file("res://scenes/options/options_menu.tscn")


func _on_quit_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
