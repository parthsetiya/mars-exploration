extends Area2D

var entered = false

func _on_body_entered(body: PhysicsBody2D):
	entered = false



func _on_body_exited(body):
	entered = true


func _process(delta):
	if entered == false:
		if Input.is_action_just_pressed("Interact"):
			get_tree().change_scene_to_file("res://maintest.tscn")

