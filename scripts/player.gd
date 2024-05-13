extends CharacterBody2D

@export var speed = 200

@onready var animations = $AnimationPlayer

@onready var inv_ui = $Inv_UI

@export var inv = Inv

var invopen = false

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func updateAnimation():
	if velocity.length() == 0: 
		animations.stop()
		
	else: 
		var direction = "Down"
		if velocity.x < 0: direction = "Left"
		elif velocity.x > 0: direction = "Right"
		elif velocity.y < 0: direction = "Up"
		elif velocity.y < 0: direction = "Idle"

		animations.play("walk" + direction)

func _physics_process(delta):
	get_input()
	move_and_slide()
	updateAnimation()
	
	
func _process(delta):
	if Input.is_action_just_pressed("Inventory"):
		invmenu()

func invmenu():
	if invopen:
		inv_ui.hide()
		speed = 200
	else:
		inv_ui.show()
		speed = 0
	invopen = !invopen
<<<<<<< HEAD
<<<<<<< HEAD

	
	
	
func collect(item):
	inv.insert(item)
	

func _on_area_2d_body_entered(body):
	pass # Replace with function body.

=======
>>>>>>> parent of cf02b60 (fixed main menu)
=======
>>>>>>> parent of cf02b60 (fixed main menu)
