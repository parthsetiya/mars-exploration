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
func _ready():
	pass

func _process(delta):
	pass

func _on_body_entered(body):
	if body.name == "Player":
		StageManager.changeStage(StageManager.MAINTEST, 100, 100)

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
