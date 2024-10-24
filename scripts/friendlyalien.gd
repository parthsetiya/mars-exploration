extends CharacterBody2D
var in_talkable = false
var player = null
var has_gottenintro = false
var playerData = PlayerData.new()
@onready var example_balloon = $ExampleBalloon
@onready var dialogue = $dialogue
signal request_inventory_update()
const REMOVE_GOLD = preload("res://Inventory/items/remove_gold.tres")
var resource = load("res://dialogue/testing.dialogue")
var title = load("res://dialogue/testing.dialogue")


# Plays NPC dialogue when the player entered the area
func _on_talkablearea_body_entered(body):
	if has_gottenintro == false:
		print("why is this not running")
		DialogueManager.show_example_dialogue_balloon(resource, "start")
		has_gottenintro = true
