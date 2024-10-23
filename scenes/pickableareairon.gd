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

