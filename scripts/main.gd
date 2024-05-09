extends Node2D

@onready var pause_menu = $Player/Camera2D/Pausemenu
var paused = false


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
