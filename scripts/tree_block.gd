extends Node2D

@onready var audio_stream_player_2d = $AudioStreamPlayer2D

var state = "no_gold"
var player_in_area = false
var gold_scene = preload("res://scenes/tree_collectable.tscn") as PackedScene
var playerData = PlayerData.new()
var player = null
var collectable = false

@export var inventory_manager: Node

@onready var respawn_timer = $Timer
@onready var animated_sprite = $AnimatedSprite2D
@onready var marker = $Marker2D
@onready var treefallinganim = $treefallinganim

const item = preload("res://Inventory/items/log.tres")

var player_node
var inventory

signal request_inventory_update()

func _ready():
	if state == "no_gold":
		respawn_timer.start() 

func _on_inventory_updated(new_inventory):
	print("new inventory: " + str(new_inventory))

func _process(delta):
	if state == "no_gold":
		animated_sprite.play("no_tree")
		#treefallinganim.play("treedown")
	elif state == "gold":
		animated_sprite.play("tree")
		treefallinganim.play("treeup")
		if player_in_area and Input.is_action_just_pressed("swing"):
			state = "falling"
			treefallinganimplayer()

func treefallinganimplayer():
	audio_stream_player_2d.play()
	treefallinganim.play("treefalling")
	await get_tree().create_timer(1.5).timeout
	treefallinganim.play("treefading")
	drop_gold()


func drop_gold():
	var gold_instance = gold_scene.instantiate()
	gold_instance.global_position = marker.global_position / 2
	get_parent().add_child(gold_instance)
	popfromground(gold_instance)
	respawn_timer.start()
	emit_signal("request_inventory_update", item.name, 1)

func popfromground(tree_collectable):
	tree_collectable.get_node("AnimatedSprite2D").show()
	tree_collectable.get_node("logdroppinganim").play("log_dropping")
	await get_tree().create_timer(1.5).timeout
	tree_collectable.get_node("logdroppinganim").play("logfading")
	await get_tree().create_timer(0.6).timeout
	tree_collectable.queue_free()



func add_item_to_inventory(item_name, quantity):
	emit_signal("request_inventory_update", item_name, quantity)

func _on_timer_timeout():
	if state == "no_gold":
		state = "gold"


func _on_intreearea_body_entered(body):
	print("in tree area")
	player_in_area = true
	player = body


func _on_intreearea_body_exited(body):
	player_in_area = false
