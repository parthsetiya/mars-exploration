extends CharacterBody2D

@export var speed = 100

@onready var animations = $AnimationPlayer

@onready var inv_ui = $Inv_UI

@export var inv: Inv

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
	position += velocity * delta
	if Input.is_action_just_pressed("Inventory"):
		invmenu()

func invmenu():
	if invopen:
		inv_ui.hide()
		speed = 100
	else:
		inv_ui.show()
		speed = 0
	invopen = !invopen
	
func collect(item):
	if inv != null:
		inv.insert(item)
	else:
		print("Inventory is not initialized, cannot collect item")

var health: int = 100
var inventory: Array = []
var save_file_path: String = "user://save_game.json"

# Function to get save data as a dictionary
func get_save_data() -> Dictionary:
	return {
		"position": position,
		"health": health,
		"inventory": inventory
	}

# Function to load save data from a dictionary
func load_save_data(data: Dictionary) -> void:
	position = data["position"]
	health = data["health"]
	inventory = data["inventory"]

