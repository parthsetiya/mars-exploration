extends Area2D

var current_scene = "world"
var entered = false

#func _ready():
#	if Global.last_world_position != Vector2(0, 0):
#		#$Tilemap/player.position = Global.last_world_position + Vector2(0, 5)

func _on_body_entered(body: PhysicsBody2D):
#	Global.last_world_position = $/root/main/Tilemap/Area2D/player.position
	entered = true

func _on_area_shape_exited():
	entered = false
	
func _process(delta):
	if entered == true:
		if Input.is_action_just_pressed("Interact"):
			get_tree().change_scene_to_file("res://scenes/housetest.tscn")
