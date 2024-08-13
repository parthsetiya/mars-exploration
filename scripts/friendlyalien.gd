extends CharacterBody2D

var in_talkable = false
var player = null
var playerData = PlayerData.new()
@onready var dialogue = $dialogue
signal request_inventory_update()
const REMOVE_GOLD = preload("res://Inventory/items/remove_gold.tres")
func _on_talkablearea_body_entered(body):
	in_talkable = true
	player = body
	

func _on_talkablearea_body_exited(body):
	in_talkable = false
	player = null
	
func _process(delta):
	if in_talkable == true:
		dialogue.show()
	
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
