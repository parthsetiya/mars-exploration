extends CharacterBody2D

@export var speed = 75
var player_chase = false
var player = null
var is_colliding = false
var speedstart = 75

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
	is_colliding = true
	speed = 0

func _on_collisionarea_body_exited(body):
	is_colliding = false
	speed = speedstart
	
