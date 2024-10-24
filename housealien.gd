extends CharacterBody2D

var playerdata = PlayerData.new()
var resource = load("res://dialogue/testing.dialogue")
var player_has_recieved_glove = false


var player_in_area = false
signal request_inventory_update(item_name, quantity)
const REMOVEFROMNPC = preload("res://Inventory/items/removefromnpc.tres")
@onready var animation_player = $AnimationPlayer



func _on_area_2d_body_entered(body):
	if body.name == "Player":
		DialogueManager.show_example_dialogue_balloon(resource, "housealien")
		player_in_area = true




