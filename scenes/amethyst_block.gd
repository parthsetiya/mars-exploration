extends Node2D


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


func _ready():
	print(amethyst_scene)
	if state == "no_amethyst":
		respawn_timer.start() 

func _on_inventory_updated(new_inventory):
	print("new inventory: " + str(new_inventory))

func _process(delta):
	if state == "no_amethyst":
		animated_sprite.play("no_amethyst")
	elif state == "amethyst":
		animated_sprite.play("amethyst")
		if player_in_area and Input.is_action_just_pressed("Interact"):
			state = "no_amethyst"
			drop_amethyst()
			add_item_to_inventory(item.name, 1)

func popfromground(amethyst_collectable):
	amethyst_collectable.get_node("AnimatedSprite2D").show()
	amethyst_collectable.get_node("AnimationPlayer").play("popfromgroundamethyst")
	await get_tree().create_timer(1.5).timeout
	amethyst_collectable.get_node("AnimationPlayer").play("fadeamethyst")
	await get_tree().create_timer(0.6).timeout
	amethyst_collectable.queue_free()

func _on_respawn_timer_timeout():
	if state == "no_amethyst":
		state = "amethyst"

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

func add_item_to_inventory(item_name, quantity):
	emit_signal("request_inventory_update", item_name, quantity)




