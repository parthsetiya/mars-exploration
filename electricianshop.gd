extends Control

var playerdata = PlayerData.new()

signal request_inventory_update
const COMPUTER_CHIP = preload("res://Inventory/items/computer_chip.tres")
const TOOLBOX = preload("res://Inventory/items/toolbox.tres")
const TOOLKIT = preload("res://Inventory/items/toolkit.tres")
const WIRES = preload("res://Inventory/items/wires.tres")


func add_item_to_inventory(item_name, quantity):
	emit_signal("request_inventory_update", item_name, quantity)


func _process(delta):
	if Input.is_action_just_pressed("shop") and not get_tree().current_scene.name == "main":
		get_tree().change_scene_to_file("res://scenes/maintest.tscn")

func _on_button_pressed():
	playerdata.load_data()
	if playerdata.invGoldIngot >= 1:
		playerdata.add_wires(2)
		playerdata.add_invGoldIngot(-1)
		playerdata.load_data()


func _on_chipbutton_pressed():
	playerdata.load_data()
	if playerdata.invGoldIngot >= 2 and playerdata.invwires >= 2:
		playerdata.add_computerchip(1)
		playerdata.add_invGoldIngot(-2)
		playerdata.add_wires(-2)
		
func _on_toolkitbutton_pressed():
	playerdata.load_data()
	if playerdata.invstick >= 5 and playerdata.invironingot >= 2:
		playerdata.add_toolkit(1)
		playerdata.add_invstick(-5)
		playerdata.add_invironingot(-2)
		playerdata.load_data()


func _on_toolboxbutton_pressed():
	playerdata.load_data()
	if playerdata.invgoldgear >= 2 and playerdata.invironingot >= 4:
		playerdata.add_toolbox(1)
		playerdata.add_goldgear(-2)
		playerdata.add_invironingot(-4)
		playerdata.load_data()
