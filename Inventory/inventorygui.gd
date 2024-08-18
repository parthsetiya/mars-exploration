extends Control

var inventory: Node

func _process(delta):
	inventory = get_node("/root/Inventory")  # Adjust path if necessary
	update_inventory_display()

func update_inventory_display():
	var inventory_text = ""
	for item in inventory.items.keys():
		inventory_text += item + ": " + str(inventory.items[item]) + "\n"
	
	$InventoryLabel.text = inventory_text  
