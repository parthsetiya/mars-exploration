extends Area2D

var entered = false


func _on_pickable_area_body_entered(body):
	entered = true


func _on_pickable_area_body_exited(body):
	entered = false
	
func _process(delta):
	if entered == true:
		print("test")
		if Input.is_action_just_pressed("Interact"):
			$gold_collectable/AnimationPlayer.play("poppingfromground")
			await get_tree().create_timer(1.5).timeout
			$gold_collectable/AnimationPlayer.play("fade")
			await get_tree().create_timer(0.6).timeout
			queue_free()
			
	else:
		print(entered)

	
