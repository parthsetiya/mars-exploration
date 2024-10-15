extends Control
var playerdata = PlayerData.new()

signal request_inventory_update
const GOLD_PICKAXE = preload("res://Inventory/items/gold_pickaxe.tres")

func add_item_to_inventory(item_name, quantity):
	emit_signal("request_inventory_update", item_name, quantity)

func _on_texture_button_pressed():
	playerdata.load_data()
	if playerdata.invpickaxehead >= 1 && playerdata.invstick >=1:
		add_item_to_inventory(GOLD_PICKAXE.name, 1)


func _on_texture_button_2_pressed():
	pass


func _on_texture_button_3_pressed():
	pass 
