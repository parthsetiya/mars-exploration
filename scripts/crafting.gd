extends Node2D
var recipeCount = 0
var recipeValues = {}
var recipes = {}
var playerdata = PlayerData.new()
var main = Main.new()
const gold_stick = preload("res://art/mainart/gold_stick.tres")
signal request_inventory_update
@onready var stickrecipe = $GridContainer/Stick/stickrecipe


# Allows player to craft a stick if they have the required item
func _on__pressed():
	playerdata.load_data()
	if playerdata.invlogingot >= 2:
		add_item_to_inventory(gold_stick.name, 1)


# Emits signal to add the item to the inventory 
func add_item_to_inventory(item_name, quantity):
	emit_signal("request_inventory_update", item_name, quantity)


