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


# Restarts the game
func _on_restart_pressed():
	reset_player_stats()
	get_tree().change_scene_to_packed(start_level)


# Resets inventory and position
func reset_player_stats():
	playerdata.add_invGoldIngot(0)
	playerdata.add_invamethystingot(0)
	playerdata.add_invironingot(0)
	playerdata.add_invlogingot(0)
	playerdata.add_invstick(0)
	playerdata.add_toolbox(0)
	playerdata.add_toolkit(0)
	playerdata.add_wires(0)
	playerdata.add_oil(0)
	playerdata.add_goldgear(0)
	playerdata.add_amethystgear(0)
	playerdata.add_cobaltgear(0)
	playerdata.add_computerchip(0)
	playerdata.add_spaceship_computer_chip(0)
	playerdata.add_spaceship_machine_parts(0)
	playerdata.add_spaceship_thruster_repair_kits(0)
	playerdata.add_spaceship_carton_of_oil(0)
	playerdata.add_spaceship_metal_plates(0)
	playerdata.add_spaceship_gold_gears(0)
	playerdata.add_spaceship_cobalt_gears(0)
	playerdata.add_spaceship_amethyst_gears(0)
	playerdata.add_spaceship_wires(0)
	playerdata.UpdatePos(Vector2(0, 0))
	playerdata.load_data()

