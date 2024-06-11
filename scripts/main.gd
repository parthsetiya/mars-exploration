extends Node2D


@onready var pause_menu = $Player/Camera2D/Pausemenu
var paused = false

@onready var interact_to_read = $TileMap/startsignpostarea/interact_to_read


@onready var start_sign_post_entered = false

func _process(delta):
	if Input.is_action_just_pressed("Pause"):
		pausemenu()
	if start_sign_post_entered == true:
		interact_to_read.show()
	elif start_sign_post_entered == false:
		interact_to_read.hide()
		
func pausemenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale =  1
	else:
		pause_menu.show()
		Engine.time_scale = 0
		


func _on_startsignpostarea_body_entered(body):
	start_sign_post_entered = true


func _on_startsignpostarea_body_exited(body):
	start_sign_post_entered = false
	


