extends Control
var playerdata = PlayerData.new()

signal request_inventory_update
const OIL = preload("res://Inventory/items/oil.tres")
const GOLD_GEAR = preload("res://Inventory/items/gold_gear.tres")
const COBALT_GEAR = preload("res://Inventory/items/cobalt_gear.tres")
const AMETHYST_GEAR = preload("res://Inventory/items/amethyst_gear.tres")

func add_item_to_inventory(item_name, quantity):
	emit_signal("request_inventory_update", item_name, quantity)

func _process(delta):
	if Input.is_action_just_pressed("shop") and not get_tree().current_scene.name == "main":
		get_tree().change_scene_to_file("res://scenes/maintest.tscn")

func _on_button_pressed():
	playerdata.load_data()
	if playerdata.invlogingot >= 6:
		playerdata.add_oil(1)
		playerdata.add_invlogingot(-6)


func _on_goldplate_pressed():
	playerdata.load_data()
	if playerdata.invGoldIngot >= 3:
		playerdata.add_goldgear(1)
		playerdata.add_invGoldIngot(-3)
		playerdata.load_data()


func _on_coplate_pressed():
	playerdata.load_data()
	if playerdata.invironingot >= 3:
		playerdata.add_cobaltgear(1)
		playerdata.add_invironingot(-3)
		playerdata.load_data()

func _on_amplate_pressed():
	playerdata.load_data()
	if playerdata.invamethystingot >= 3:
		playerdata.add_amethystgear(1)
		playerdata.add_invamethystingot(-3)
		playerdata.load_data()
