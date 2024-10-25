extends Node2D
@onready var pickaxe_sound = $AudioStreamPlayer2D
var state = "no_gold"
var player_in_area = false
var gold_scene = preload("res://scenes/gold_collectable.tscn") as PackedScene
var playerData = PlayerData.new()
var playerscript = Player.new()
var player = null
var collectable = false
var gold_collected = false
const GOLD_PICKAXE = preload("res://Inventory/items/gold_pickaxe.tres")
@export var inventory_manager: Node
@onready var respawn_timer = $respawn_timer
@onready var animated_sprite = $AnimatedSprite2D
@onready var marker = $Marker2D
const item = preload("res://Inventory/items/gold.tres")
var player_node
var inventory
var current_gold
@export var outline_frame: int = 1  
@export var normal_frame: int = 0  
signal request_inventory_update()


# Spawn gold when game is run
func _ready():
	state = "gold"



# Check to see if the player has mined the ore, and if they have then play animation and add the item to the inventory
func _process(delta):
	if state == "no_gold":
		animated_sprite.play("no_gold")
		gold_collected = false
	elif state == "gold":
		animated_sprite.play("gold")
		if player_in_area and Input.is_action_just_pressed("swing") and not gold_collected:
			gold_collected = true
			await get_tree().create_timer(0.6).timeout
			state = "no_gold"
			drop_gold()
			pickaxe_sound.play()
			add_item_to_inventory(item.name, 1)


# Plays the animation of the ingot dropping to the ground
func popfromground(gold_collectable):
	gold_collectable.get_node("AnimatedSprite2D").show()
	gold_collectable.get_node("AnimationPlayer2").play("poppingfromground")
	await get_tree().create_timer(1.5).timeout
	gold_collectable.get_node("AnimationPlayer2").play("fade")
	await get_tree().create_timer(0.6).timeout
	gold_collectable.queue_free()


# When the timer for the respawn is complete make the ore spawn again
func _on_respawn_timer_timeout():
	if state == "no_gold":
		state = "gold"


# Sets the item that is dropped on the ground to the correct texture via the collectable attached to the node tree, and ensures it drops at the correct position
func drop_gold():
	var gold_instance = gold_scene.instantiate()
	gold_instance.global_position = marker.global_position / 2
	get_parent().add_child(gold_instance)
	popfromground(gold_instance)
	await get_tree().create_timer(3).timeout
	respawn_timer.start()


func _on_area_2d_body_entered(body):
	player_in_area = true
	player = body


func _on_area_2d_body_exited(body):
	player_in_area = false

# Emits signal to add item to inventory 
func add_item_to_inventory(item_name, quantity):
	emit_signal("request_inventory_update", item_name, quantity)
	



