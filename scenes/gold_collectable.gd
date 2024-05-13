extends StaticBody2D



func _ready():
	popfromground()
	
	
func popfromground():
	$AnimationPlayer.play("poppingfromground")
	await get_tree().create_timer(1.5).timeout
	$AnimationPlayer.play("fade")
	await get_tree().create_timer(0.6).timeout
	queue_free()


