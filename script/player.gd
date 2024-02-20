extends CharacterBody2D

@export var speed = 200
@onready var animations = $AnimationPlayer
func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func updateAnimation():
	$AnimationTree.set("parameters/Idle/blend_position", velocity)
	if velocity.length() == 0: 
		animations.stop()
		
	else: 
		var direction = "Down"
		if velocity.x < 0: direction = "Left"
		elif velocity.x > 0: direction = "Right"
		elif velocity.y < 0: direction = "Up"
		#elif velocity.x < 0: direction = "Idle" 

		animations.play("walk" + direction)

func _physics_process(delta):
	get_input()
	move_and_slide()
	updateAnimation()
