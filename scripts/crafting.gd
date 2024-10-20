extends Node2D

var recipeCount = 0
var recipeValues = {}
var recipes = {}
var playerdata = PlayerData.new()
var main = Main.new()
const gold_stick = preload("res://art/mainart/gold_stick.tres")
const GOLD_PICKAXE = preload("res://Inventory/items/gold_pickaxe.tres")
signal request_inventory_update
@onready var stickrecipe = $GridContainer/Stick/stickrecipe
const WOODEN_PICKAXE = preload("res://Inventory/items/wooden_pickaxe.tres")

var items = { 3 : "Stick",
			  1 : "Cobble",
			  2 : "Plank"}

func _ready():
	load_game()

func createRecipe(rec, nam):
	recipeValues[recipeCount] = rec
	recipeCount += 1
	recipes[str(rec)] = nam
	print("NEW RECIPE")
	print(recipes[str(rec)], " : ", rec)
	save_game()
	
func save():
	var save_dict = [ recipes,
					  recipeValues,
					  recipeCount]
	
	return save_dict

func save_game():
	var save_game = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	
	var json_string = JSON.stringify(save())
	
	save_game.store_line(json_string)

func load_game():
	if not FileAccess.file_exists("user://savegame.save"):
		return
	
	var save_game = FileAccess.open("user://savegame.save", FileAccess.READ)
	
	while save_game.get_position() < save_game.get_length():
		var json_string = save_game.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		var node_data = json.get_data()
		
		recipes = node_data[0]
		recipeValues = node_data[1]
		recipeCount = node_data[2]


func _on__pressed():
	playerdata.load_data()
	if playerdata.invlogingot >= 2:
		add_item_to_inventory(gold_stick.name, 1)
		

func add_item_to_inventory(item_name, quantity):
	emit_signal("request_inventory_update", item_name, quantity)


func _on_gold_pick_pressed():
	playerdata.load_data()
	if playerdata.invGoldIngot >= 3 and playerdata.invstick >= 2:
		print("making gold stick")
		add_item_to_inventory(GOLD_PICKAXE.name, 1)

#
#func _on_stick_mouse_entered():
	#stickrecipe.show()
	#
#
#
#func _on_stick_mouse_exited():
	#stickrecipe.hide()


func _on_texture_button_pressed():
	playerdata.load_data()
	if playerdata.invlogingot >= 3 and playerdata.invstick >= 2:
		print("making gold stick")
		add_item_to_inventory(WOODEN_PICKAXE.name, 1)
