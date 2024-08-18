extends Node2D

var player_in_area = false
var gold_collected = false
@onready var animated_sprite = $AnimatedSprite2D


func _process(delta):
	if player_in_area and Input.is_action_just_pressed("swing") and not gold_collected:
		print("running")
		gold_collected = true
		await get_tree().create_timer(0.6).timeout
		var inventory = get_node("/root/Inventory") 
		Inventory.add_item("gold", 1)
		animated_sprite.hide()

		await get_tree().create_timer(3).timeout
		animated_sprite.show()
		gold_collected = false
#
func _on_area_2d_body_entered(body):
	player_in_area = true


func _on_area_2d_body_exited(body):
	player_in_area = false




