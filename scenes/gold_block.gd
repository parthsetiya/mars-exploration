extends Node2D

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

signal request_inventory_update()


func _ready():
	print(gold_scene)
	if state == "no_gold":
		respawn_timer.start() 

func _on_inventory_updated(new_inventory):
	print("new inventory: " + str(new_inventory))

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
			add_item_to_inventory(item.name, 1)

func popfromground(gold_collectable):
	gold_collectable.get_node("AnimatedSprite2D").show()
	gold_collectable.get_node("AnimationPlayer2").play("poppingfromground")
	await get_tree().create_timer(1.5).timeout
	gold_collectable.get_node("AnimationPlayer2").play("fade")
	await get_tree().create_timer(0.6).timeout
	gold_collectable.queue_free()

func _on_respawn_timer_timeout():
	if state == "no_gold":
		state = "gold"

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

func add_item_to_inventory(item_name, quantity):
	emit_signal("request_inventory_update", item_name, quantity)


@export var outline_frame: int = 1  
@export var normal_frame: int = 0  

func _on_area2d_body_entered(body: Node2D):
	if body.is_in_group("Player"):  
		animated_sprite.frame = outline_frame  

	else:
		animated_sprite.frame = normal_frame  
func _on_area2d_body_exited(body: Node2D):
	if body.is_in_group("Player"):
		animated_sprite.frame = normal_frame



