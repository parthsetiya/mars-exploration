extends Node2D

@onready var player_break = $AudioStreamPlayer2D

var state = "no_iron"
var player_in_area = false
var iron_scene = preload("res://scenes/iron_collectable.tscn") as PackedScene
var playerData = PlayerData.new()
var player = null
var collectable = false

@export var inventory_manager: Node

@onready var respawn_timer = $respawn_timeriron
@onready var animated_sprite = $AnimatedSprite2D
@onready var marker = $Marker2D

const item = preload("res://Inventory/items/iron.tres")

var player_node
var inventory
var current_iron

signal request_inventory_update()

func _ready():
	if state == "no_iron":
		respawn_timer.start()
	
	print("animated_sprite: ", animated_sprite)  # Debugging line
	if animated_sprite == null:
		print("Error: animated_sprite is null!")

func _on_inventory_updated(new_inventory):
	print("new inventory: " + str(new_inventory))

func _process(delta):
	if state == "no_iron":
		if animated_sprite:
			animated_sprite.play("no_iron")
	elif state == "iron":
		if animated_sprite:
			animated_sprite.play("iron")
		if player_in_area and Input.is_action_just_pressed("swing"):
			await get_tree().create_timer(0.6).timeout
			state = "no_iron"
			drop_iron()
			player_break.play()
			add_item_to_inventory(item.name, 1)

func popfromground(iron_collectable):
	iron_collectable.get_node("AnimatedSprite2D").show()
	iron_collectable.get_node("AnimationPlayer").play("poppingfromgroundiron")
	await get_tree().create_timer(1.5).timeout
	iron_collectable.get_node("AnimationPlayer").play("fadeiron")
	await get_tree().create_timer(0.6).timeout
	iron_collectable.queue_free()
	print("test")

func _on_respawn_timer_timeout():
	if state == "no_iron":
		state = "iron"

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

func add_item_to_inventory(item_name, quantity):
	emit_signal("request_inventory_update", item_name, quantity)


