extends Area2D


# Variable to store the player's position
var player_position = Vector2()

# Function to get and store the player's position
func get_player_position():
	# Access the player's position property and store it in the variable
	player_position = position

# Example usage
#get_player_position()
#print("Player's position:", player_position)


func _ready():
	pass

func _process(delta):
	pass

func _on_body_entered(body):
	if body.name == "Player":
		get_player_position()
		StageManager.changeStage(StageManager.MAINTEST, 0, -400)

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
