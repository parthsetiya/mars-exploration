extends Area2D
var animation = preload("res://scenes/gold_collectable.tscn") as PackedScene
@onready var gold_collectable = $gold_collectable
@onready var gold_block = $".."
var entered = false
var collectable = false
var current_gold


func _on_body_entered(body):
	print($AnimationPlayer)
	entered = true


func _on_body_exited(body):
	entered = false

