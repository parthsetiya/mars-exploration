extends CharacterBody2D
class_name Player
@onready var animations = $AnimationPlayer
@onready var gold_block = $gold_block
const GOLD_PICKAXE = preload("res://Inventory/items/gold_pickaxe.tres")
var GOLD = load("res://Inventory/items/gold.tres")
@onready var speed = 100
var is_swinging = false
var save_file_path = "user://save/"
var save_file_name = "PlayerSave.tres"
var playerData = PlayerData.new()
var input_direction
var direction = "right"
var playerholdingpick
@onready var toolanim = $Node2D/AnimationPlayer
@onready var node_2d = $Node2D


# Sets player position to last saved position
func _ready():
	playerData.load_data()
	self.position = playerData.SavePos


# Get direction of the player and play a swing animation based on the direction the player is facing
func _process(delta):
	position += velocity * delta
	if Input.is_action_just_pressed("right"):
		direction = "right"
	if Input.is_action_just_pressed("left"):
		direction = "left"
	if Input.is_action_just_pressed("swing") and not is_swinging:
		$AudioStreamPlayer2D.play()
		print(playerData.current_item)
		swing_tool()
	if playerData.SavePos != self.position:
		playerData.UpdatePos(self.position)


# Function for playing the swinging of the tool animation
func swing_tool():
	if is_swinging:
		return 

	is_swinging = true
	node_2d.show()
	speed = 0  

	if direction == "right":
		animations.play("axeswingright")
		toolanim.play("toolswingright")
	elif direction == "left":
		animations.play("axeswingleft")
		toolanim.play("toolswingleft")


	# Wait for the animation to finish
	await get_tree().create_timer(0.6).timeout
	
	node_2d.hide() 
	is_swinging = false
	speed = 100 


# Gets the direction of the player and moves them in that direction
func get_input():
	input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed


# Plays animation based on what directon the player is walking
func updateAnimation():
	if not is_swinging:
		if velocity.length() == 0: 
			animations.stop()
			
		elif is_swinging == false:
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

