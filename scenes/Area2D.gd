extends Area2D


var entered = false

func _on_body_entered(body: PhysicsBody2D):
	entered = true
	



func _on_area_shape_exited():
	entered = false
	
func _process(delta):
	if entered == true:
		if Input.is_action_just_pressed("Interact"):
			get_tree().change_scene_to_file("res://housetest.tscn")
