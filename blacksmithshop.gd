extends Control
var playerdata = PlayerData.new()

signal request_inventory_update
const OIL = preload("res://Inventory/items/oil.tres")
const GOLD_GEAR = preload("res://Inventory/items/gold_gear.tres")
const COBALT_GEAR = preload("res://Inventory/items/cobalt_gear.tres")
const AMETHYST_GEAR = preload("res://Inventory/items/amethyst_gear.tres")
func add_item_to_inventory(item_name, quantity):
	emit_signal("request_inventory_update", item_name, quantity)


func _on_button_pressed():
	playerdata.load_data()
	if playerdata.invlogingot >= 6:
		add_item_to_inventory(OIL.name, 1)


func _on_goldplate_pressed():
	playerdata.load_data()
	if playerdata.invGoldIngot >= 3:
		add_item_to_inventory(GOLD_GEAR.name, 1)


func _on_coplate_pressed():
	playerdata.load_data()
	if playerdata.invironingot >= 3:
		add_item_to_inventory(COBALT_GEAR.name, 1)


func _on_amplate_pressed():
	playerdata.load_data()
	if playerdata.invamethystingot >= 3:
		add_item_to_inventory(AMETHYST_GEAR.name, 1)
