extends CharacterBody2D

var playerdata = PlayerData.new()
var resource = load("res://dialogue/testing.dialogue")
var player_has_recieved_glove = false
const GLOVE = preload("res://Inventory/items/glove.tres")

var player_in_area = false
signal request_inventory_update(item_name, quantity)


func _process(delta):
	if player_in_area and not player_has_recieved_glove:
		if Input.is_action_just_pressed("g"):
			add_item_to_inventory(GLOVE.name, 1)
			player_has_recieved_glove = true  


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		DialogueManager.show_example_dialogue_balloon(resource, "housealien")
		player_in_area = true


func _on_area_2d_body_exited(body):
	if body.name == "Player":
		player_in_area = false


func add_item_to_inventory(item_name, quantity):
	emit_signal("request_inventory_update", item_name, quantity)
	print("Added glove to inventory")
