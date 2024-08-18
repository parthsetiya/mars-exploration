extends CharacterBody2D

var in_talkable = false
var player = null
var playerData = PlayerData.new()
@onready var example_balloon = $ExampleBalloon
@onready var dialogue = $dialogue
signal request_inventory_update()
const REMOVE_GOLD = preload("res://Inventory/items/remove_gold.tres")
var resource = load("res://dialogue/testing.dialogue")
var title = load("res://dialogue/testing.dialogue")

#var dialogue_line = await resource.get_next_dialogue_line("start")

func _on_talkablearea_body_entered(body):
	in_talkable = true
	player = body
	if Input.is_action_just_pressed("Interact"):
		DialogueManager.show_example_dialogue_balloon(resource, "start")



func _on_talkablearea_body_exited(body):
	in_talkable = false
	player = null
	
func _process(delta):
	if in_talkable == true:
		
		if Input.is_action_just_pressed("Interact"):
			playerData.load_data() 
			if playerData.invGoldIngot >=2:
				print("interacted to remove gold")
				add_item_to_inventory(REMOVE_GOLD.name, 1)
				dialogue.hide()
	else:
		dialogue.hide()

func add_item_to_inventory(item_name, quantity):
	emit_signal("request_inventory_update", item_name, quantity)
