#extends Label
#
#var inventory: Node
#
#func _ready():
	#print("inventory gui is ready")
	#inventory = get_node("/root/Inventory")  # Adjust path if necessary
	#update_inventory_display()
#
#func update_inventory_display():
	#print("inventory updating")
	#var inventory_text = ""
	#for item in inventory.items.keys():
		#inventory_text += item + ": " + str(inventory.items[item]) + "\n"
	#
	#$InventoryLabel.text = inventory_text  
