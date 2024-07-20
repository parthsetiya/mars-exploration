extends Area2D

var animation = preload("res://scenes/iron_collectable.tscn") as PackedScene
@onready var iron_collectable = $iron_collectable
@onready var iron_block = $".."

var entered = false
var collectable = false
var current_iron

func _on_body_entered(body):
	print($AnimationPlayer)
	entered = true


func _on_body_exited(body):
	entered = false
	


#func popfromground():
	#$iron_collectable/AnimatedSprite2D.show()
	#$iron_collectable/AnimationPlayer2.play("poppingfromgroundiron")
	#await get_tree().create_timer(1.5).timeout
	#$iron_collectable/AnimationPlayer2.play("fadeiron")
	#await get_tree().create_timer(0.6).timeout
	#queue_free()
	#
	#
#func _process(delta):
	#if entered == true:
		#if Input.is_action_just_pressed("Interact"):
			#popfromground()
			
			
			

