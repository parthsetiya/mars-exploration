extends Control
var playerdata = PlayerData.new()

signal request_inventory_update
const GEAR = preload("res://Inventory/items/gear.tres")

func add_item_to_inventory(item_name, quantity):
	emit_signal("request_inventory_update", item_name, quantity)

func _on_texture_button_pressed():
	playerdata.load_data()
	if playerdata.invGoldIngot >= 4 && playerdata.invironingot >=6:
		add_item_to_inventory(GEAR.name, 1)


func _on_texture_button_2_pressed():
	pass


func _on_texture_button_3_pressed():
	pass 
