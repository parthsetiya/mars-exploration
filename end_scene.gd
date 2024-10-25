extends Node2D
@onready var animation = $AnimationPlayer


# Quits game
func _ready():
	animation.play("fade out")
	await get_tree().create_timer(5).timeout
	get_tree().quit()

