extends Node2D
@onready var player_sound = $AudioStreamPlayer2D
var state = "no_amethyst"
var player_in_area = false
var amethyst_scene = preload("res://scenes/amethyst_collectable.tscn") as PackedScene
var playerData = PlayerData.new()
var player = null
var collectable = false
@export var inventory_manager: Node
@onready var respawn_timer = $respawn_timer
@onready var animated_sprite = $AnimatedSprite2D
@onready var marker = $Marker2D
const item = preload("res://Inventory/items/amethyst.tres")
var player_node
var inventory
var current_amethyst
signal request_inventory_update()


# Start the respawn timer if there’s no ore
func _ready():
	state = "gold"


# Check to see if the player has mined the ore, and if they have then play animation and add the item to the inventory
func _process(delta):
	if state == "no_amethyst":
		animated_sprite.play("no_amethyst")
	elif state == "amethyst":
		animated_sprite.play("amethyst")
		if player_in_area and Input.is_action_just_pressed("swing"):
			await get_tree().create_timer(0.6).timeout
			state = "no_amethyst"
			drop_amethyst()
			player_sound.play()
			add_item_to_inventory(item.name, 1)


# Plays the animation of the ingot dropping to the ground
func popfromground(amethyst_collectable):
	amethyst_collectable.get_node("AnimatedSprite2D").show()
	amethyst_collectable.get_node("AnimationPlayer").play("popfromgroundamethyst")
	await get_tree().create_timer(1.5).timeout
	amethyst_collectable.get_node("AnimationPlayer").play("fadeamethyst")
	await get_tree().create_timer(0.6).timeout
	amethyst_collectable.queue_free()


# When the timer for the respawn is complete make the ore spawn again
func _on_respawn_timer_timeout():
	if state == "no_amethyst":
		state = "amethyst"


# Sets the item that is dropped on the ground to the correct texture via the collectable attached to the node tree, and ensures it drops at the correct position
func drop_amethyst():
	var amethyst_instance = amethyst_scene.instantiate()
	amethyst_instance.global_position = marker.global_position / 2
	get_parent().add_child(amethyst_instance)
	popfromground(amethyst_instance)
	await get_tree().create_timer(3).timeout
	respawn_timer.start()
	emit_signal("request_inventory_update", item.name, 1)


func _on_area_2d_body_entered(body):
	player_in_area = true
	player = body


func _on_area_2d_body_exited(body):
	player_in_area = false


# Emits signal to add item to inventory 
func add_item_to_inventory(item_name, quantity):
	emit_signal("request_inventory_update", item_name, quantity)




