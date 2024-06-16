extends CharacterBody2D

@export var speed = 75
var player_chase = false
var player = null
var is_colliding = false
var speedstart = 75
var playerData = PlayerData.new()

func _ready():
	speed = speedstart

func _physics_process(delta):
	if player_chase and not is_colliding:
		position += (player.position - position).normalized() * speed * delta
		

func _on_detectionarea_body_entered(body):
	player = body
	player_chase = true

func _on_detectionarea_body_exited(body):
	player = null
	player_chase = false


func _on_collisionarea_body_entered(body):
	if body.name == "Player":
		print("collision worked")
		playerData.change_health(-100) 
		print(playerData.health) # Set player's health to zero
		body.check_health()  # Check if the player should die
		is_colliding = true
		speed = 0

func _on_collisionarea_body_exited(body):
	is_colliding = false
	speed = speedstart
	
