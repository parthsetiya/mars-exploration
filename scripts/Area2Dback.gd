extends Area2D

#@onready var E_to_interact = $E_to_interact

#var spawn_point = Vector2()
#var entered = false
#var tooltipshow = false

#func _on_body_entered(body: PhysicsBody2D):
	#entered = true
#
#func _on_body_exited(body):
	#entered = false
	#
#func set_spawn_point(point):
	#if entered == true:
		#spawn_point = point
#
#func move_player_to_spawn():
	#$Player.position = spawn_point
	#$Player.position = spawn_point
	#
func _on_body_entered(body):
	if body.name == "Player":
		StageManager.changeStage(StageManager.MAINTEST)
	
#func _process(delta):
	#if entered == true:
		#
		#etointeractshow()
		#if Input.is_action_just_pressed("Interact"):
			#
			#move_player_to_spawn()
			#get_tree().change_scene_to_file("res://scenes/maintest.tscn")
			#
	#else:
		#etointeracthide()
		#
#
#func etointeractshow():
	#if tooltipshow:
		#E_to_interact.show()
		#
	#tooltipshow = !tooltipshow
	#
#func etointeracthide():
		#E_to_interact.hide()
		#
		#
		
#extends Area2D
#
#@onready var E_to_interact = $E_to_interact
#
#var spawn_point = Vector2()
#var entered = false
#var tooltipshow = false
#
#func _on_body_entered(body: PhysicsBody2D):
	#entered = true
	## Set the spawn point when the player enters the area
	#set_spawn_point()
#
#func _on_body_exited(body: PhysicsBody2D):
	#entered = false
#
## Function to set the spawn point
#func set_spawn_point():
	#if entered:
		#spawn_point = global_position  # Store the current position as the spawn point
#
## Function to move the player to the spawn point
#func move_player_to_spawn():
	#$Player.position = spawn_point
#
#func _process(delta):
	#if entered:
		#etointeractshow()
		#if Input.is_action_just_pressed("Interact"):
			#move_player_to_spawn()  # Move the player to the spawn point
			#get_tree().change_scene("res://scenes/maintest.tscn")  # Transition to the main scene
	#else:
		#etointeracthide()
#
#func etointeractshow():
	#if not tooltipshow:
		#E_to_interact.show()
	#tooltipshow = true
#
#func etointeracthide():
	#if tooltipshow:
		#E_to_interact.hide()
	#tooltipshow = false
