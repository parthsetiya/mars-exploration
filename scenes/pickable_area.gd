extends Area2D

var animation = preload("res://scenes/gold_collectable.tscn") as PackedScene
@onready var gold_collectable = $gold_collectable
@onready var gold_block = $".."

var entered = false

func _on_body_entered(body):
	print($AnimationPlayer)
	entered = true


func _on_body_exited(body):
	entered = false

func popfromground():
	$gold_collectable/AnimatedSprite2D.show()
	$gold_collectable/AnimationPlayer2.play("poppingfromground")
	await get_tree().create_timer(1.5).timeout
	$gold_collectable/AnimationPlayer2.play("fade")
	await get_tree().create_timer(0.6).timeout
	queue_free()
	
	
func _process(delta):
	if entered == true:
		if Input.is_action_just_pressed("Interact"):
			popfromground()
			
			
			

	




