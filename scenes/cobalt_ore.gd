extends Node2D

@onready var player_break = $AudioStreamPlayer2D

var state = "iron"
var player_in_area = false
var iron_scene = preload("res://scenes/iron_collectable.tscn") as PackedScene
var playerData = PlayerData.new()
var player = null
var collectable = false
var collected_iron = false

@export var inventory_manager: Node

@onready var respawn_timer = $respawn_timeriron
@onready var animated_sprite = $AnimatedSprite2D
@onready var marker = $Marker2D

const item = preload("res://Inventory/items/iron.tres")

var player_node
var inventory
var current_iron

signal request_inventory_update()




# Check to see if the player has mined the ore, and if they have then play animation and add the item to the inventory
func _process(delta):
	if state == "no_iron":
		animated_sprite.play("no_iron")
		collected_iron = false
	elif state == "iron":
		animated_sprite.play("iron")
		if player_in_area and Input.is_action_just_pressed("swing") and not collected_iron:
			collected_iron = true
			await get_tree().create_timer(0.6).timeout
			state = "no_iron"
			drop_iron()
			player_break.play()
			add_item_to_inventory(item.name, 1)
			


# Plays the animation of the ingot dropping to the ground
func popfromground(iron_collectable):
	iron_collectable.get_node("AnimatedSprite2D").show()
	iron_collectable.get_node("AnimationPlayer").play("poppingfromgroundiron")
	await get_tree().create_timer(1.5).timeout
	iron_collectable.get_node("AnimationPlayer").play("fadeiron")
	await get_tree().create_timer(0.6).timeout
	iron_collectable.queue_free()
	print("test")


# When the timer for the respawn is complete make the ore spawn again
func _on_respawn_timer_timeout():
	if state == "no_iron":
		state = "iron"


# Sets the item that is dropped on the ground to the correct texture via the collectable attached to the node tree, and ensures it drops at the correct position
func drop_iron():
	var iron_instance = iron_scene.instantiate()
	iron_instance.global_position = marker.global_position / 2
	get_parent().add_child(iron_instance)
	popfromground(iron_instance)
	await get_tree().create_timer(3).timeout
	respawn_timer.start()


func _on_area_2d_body_entered(body):
		player_in_area = true
		player = body


func _on_area_2d_body_exited(body):
		player_in_area = false


# Emits signal to add the item to the inventory 
func add_item_to_inventory(item_name, quantity):
	emit_signal("request_inventory_update", item_name, quantity)


