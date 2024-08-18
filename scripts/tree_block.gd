extends Node2D

var player_in_area = false
var is_collected = false
@onready var animated_sprite = $Sprite2D


func _process(delta):
	if player_in_area and Input.is_action_just_pressed("swing") and not is_collected:
		print("running way too many times for some rzn")
		is_collected = true
		await get_tree().create_timer(0.6).timeout
		var inventory = get_node("/root/Inventory") 
		Inventory.add_item("Wood", 1)
		animated_sprite.hide()

		await get_tree().create_timer(3).timeout
		animated_sprite.show()
		is_collected = false
#
func _on_area_2d_body_entered(body):
	player_in_area = true


func _on_area_2d_body_exited(body):
	player_in_area = false
