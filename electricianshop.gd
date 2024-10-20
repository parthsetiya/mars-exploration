extends Control

var playerdata = PlayerData.new()

signal request_inventory_update
const COMPUTER_CHIP = preload("res://Inventory/items/computer_chip.tres")
const TOOLBOX = preload("res://Inventory/items/toolbox.tres")
const TOOLKIT = preload("res://Inventory/items/toolkit.tres")
const WIRES = preload("res://Inventory/items/wires.tres")


func add_item_to_inventory(item_name, quantity):
	emit_signal("request_inventory_update", item_name, quantity)


func _on_button_pressed():
	playerdata.load_data()
	if playerdata.invGoldIngot >= 1:
		add_item_to_inventory(WIRES.name, 1)


func _on_chipbutton_pressed():
	playerdata.load_data()
	if playerdata.invGoldIngot >= 2 and playerdata.invwires >= 2:
		add_item_to_inventory(COMPUTER_CHIP.name, 1)


func _on_toolkitbutton_pressed():
	playerdata.load_data()
	if playerdata.invstick >= 5 and playerdata.invironingot >= 2:
		add_item_to_inventory(TOOLKIT.name, 1)


func _on_toolboxbutton_pressed():
	playerdata.load_data()
	if playerdata.invgoldgear >= 2 and playerdata.invironingot >= 4:
		add_item_to_inventory(TOOLBOX.name, 1)
