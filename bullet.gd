extends Node2D

var speed = 300


func _ready():
	pass # Replace with function body.



func _process(delta):
	position += (Vector2.RIGHT*speed).rotated(rotation) * delta
	
	



func _on_visible_on_screen_enabler_2d_screen_entered():
	queue_free()
