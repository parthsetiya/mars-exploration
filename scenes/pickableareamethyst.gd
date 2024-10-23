extends Area2D
var animation = preload("res://scenes/iron_collectable.tscn") as PackedScene
@onready var amethyst_collectable = $amethyst_collectable
@onready var amethyst_block = $".."
var entered = false
var collectable = false


func _on_body_entered(body):
	print($AnimationPlayer)
	entered = true


func _on_body_exited(body):
	entered = false

