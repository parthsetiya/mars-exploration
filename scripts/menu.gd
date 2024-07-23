class_name MainMenu
extends Control

@onready var playbutton = $MarginContainer/HBoxContainer/VBoxContainer/playbutton as Button
@onready var player = $Player
@onready var save_load_manager = $SaveLoadManager
@onready var options_menu = $options_menu as OptionsMenu
@onready var margin_container = $MarginContainer as MarginContainer

@onready var start_level = preload("res://scenes/maintest.tscn") as PackedScene

var playerdata = PlayerData.new()

func _ready():
	pass
	
func on_options_pressed() -> void:
	margin_container.visible = false
	options_menu.visible = true
	
func on_exit_option_menu() -> void:
	pass	
	
func _on_texture_button_2_pressed():
	get_tree().change_scene_to_file("res://scenes/options/scenes/options_menu.tscn")


func _on_texture_button_3_pressed():
	get_tree().quit()
	

func _on_playbutton_pressed():
	get_tree().change_scene_to_packed(start_level)
	playerdata.load_data()



