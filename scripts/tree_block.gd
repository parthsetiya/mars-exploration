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
var tree_collected = false
signal request_inventory_update()

# Sets the tree to spawn when the game is started
func _ready():
	state = "gold"


# Detects when tree is broken and plays animation and adds item to inventory 
func _process(delta):
	if state == "no_gold":
		animated_sprite.play("no_tree")
		#treefallinganim.play("treedown")
		tree_collected = false
	elif state == "gold":
		animated_sprite.play("tree")
		treefallinganim.play("treeup")
		if player_in_area and Input.is_action_just_pressed("swing") and tree_collected == false:
			state = "falling"
			treefallinganimplayer()
			tree_collected = true


# Plays the tree falling animation
func treefallinganimplayer():
	audio_stream_player_2d.play()
	treefallinganim.play("treefalling")
	await get_tree().create_timer(1.5).timeout
	treefallinganim.play("treefading")
	drop_gold()

# Plays the log dropping on the ground 
func drop_gold():
	var gold_instance = gold_scene.instantiate()
	gold_instance.global_position = marker.global_position / 2
	get_parent().add_child(gold_instance)
	popfromground(gold_instance)
	respawn_timer.start()
	emit_signal("request_inventory_update", item.name, 1)
	state = "no_gold"


func popfromground(tree_collectable):
	tree_collectable.get_node("AnimatedSprite2D").show()
	tree_collectable.get_node("logdroppinganim").play("log_dropping")
	await get_tree().create_timer(1.5).timeout
	tree_collectable.get_node("logdroppinganim").play("logfading")
	await get_tree().create_timer(0.6).timeout
	tree_collectable.queue_free()


# Emits signal to add item to inventory
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

