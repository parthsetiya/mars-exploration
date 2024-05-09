#extends Area2D
#
#
#@onready var E_to_interact = $E_to_interact
	#
#var entered = false
#var spawn_point = Vector2()
#var tooltipshow = false
#
#func _on_body_entered(body: PhysicsBody2D):
	#entered = true
#
#
#func _on_body_exited(body):
	#entered = false
#
#func set_spawn_point(point):
	#spawn_point = point
	#
#func move_player_to_spawn():
	#$Player.position = spawn_point
#
#func _process(delta):
	#if entered == true:
		#etointeractshow()
		#if Input.is_action_just_pressed("Interact"):
			##set_spawn_point($Door.position)
			#Player.position = Vector2(100,100)
			#get_tree().change_scene_to_file("res://housetest.tscn")
			#
	#else:
		#etointeracthide()
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
	

extends Area2D

func ready():
	pass

func _process(delta):
	pass
	
func _on_body_entered(body):
	if body.name == "Player":
		StageManager.changeStage(StageManager.HOUSETEST)
