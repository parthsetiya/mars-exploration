extends Node2D


@onready var pause_menu = $Player/Camera2D/Pausemenu
var paused = false
@onready var player = $Player
@onready var save_load_manager = $SaveLoadManager


func _process(delta):
	if Input.is_action_just_pressed("Pause"):
		pausemenu()
		
func pausemenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale =  1
	else:
		pause_menu.show()
		Engine.time_scale = 0
		
	paused = !paused
	

func _on_SaveButton_pressed() -> void:
	save_load_manager.save_game(player)

func _on_LoadButton_pressed() -> void:
	save_load_manager.load_game(player)
