extends Area2D

@onready var E_to_interact = $E_to_interact

var entered = false
var tooltipshow = false

func _on_body_entered(body: PhysicsBody2D):
	entered = true

func _on_body_exited(body):
	entered = false
	
func _process(delta):
	if entered == true:
		etointeractshow()
		if Input.is_action_just_pressed("Interact"):
			get_tree().change_scene_to_file("res://scenes/maintest.tscn")
			
	else:
		etointeracthide()
		

func etointeractshow():
	if tooltipshow:
		E_to_interact.show()
		
	tooltipshow = !tooltipshow
	
func etointeracthide():
		E_to_interact.hide()









