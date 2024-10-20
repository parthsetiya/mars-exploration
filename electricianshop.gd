extends Control

var playerdata = PlayerData.new()

signal request_inventory_update

func add_item_to_inventory(item_name, quantity):
	emit_signal("request_inventory_update", item_name, quantity)


func _on_button_pressed():
	print("I have autism")
