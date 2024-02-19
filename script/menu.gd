class_name MainMenu
extends Control

@onready var play = $MarginContainer/HBoxContainer/VBoxContainer/play as Button
@onready var settings = $MarginContainer/HBoxContainer/VBoxContainer/options as Button
@onready var quit = $MarginContainer/HBoxContainer/VBoxContainer/quit as Button
@onready var options_menu = $options_menu as OptionsMenu
@onready var margin_container = $MarginContainer as MarginContainer

@onready var start_level = preload("res://scenes/main.tscn") as PackedScene


func _ready():
	handle_connecting_signals()
	
func on_start_pressed() -> void:
	get_tree().change_scene_to_packed(start_level)
	

func on_options_pressed() -> void:
	margin_container.visible = false
	options_menu.visible = true

func on_exit_button_pressed() -> void:
	get_tree().quit()
	
func on_exit_option_menu() -> void:
	pass
	
func handle_connecting_signals() -> void:
	play.button_down.connect(on_start_pressed)
	#settings.button_down.connect(on_options_pressed)	
	quit.button_down.connect(on_exit_button_pressed)
	options_menu.exit_options_menu.connect(on_exit_option_menu)
	


func _on_settings_pressed():
	get_tree().change_scene_to_file("res://scenes/options/options_menu.tscn")



