#extends Control
#
#var inventory: Node
#
#func _ready():
	#print("runnnnnn")
	#inventory = get_node("/root/Inventory")
	#update_inventory_display()
#
#func _process(delta):
	#update_inventory_display()
#
#func update_inventory_display():
	#var inventory_text = ""
	#for item in inventory.items.keys():
		#inventory_text += item + ": " + str(inventory.items[item]) + "\n"
	#
	#$InventoryLabel.text = inventory_text  
#
#var recipes = {
	#"Stick": {"Wood": "2"},
	#"Golden joint": {"Stick": "1", "Gold": "4"}
#}
#
#func craft_item(item_name: String):
	#if item_name in recipes.keys():
		#if inventory.craft_item(recipes[item_name], item_name):
			#update_inventory_display()
			#print("Successfully crafted " + item_name)
		#else:
			#print("Not enough resources to craft " + item_name)
	#else:
		#print("Recipe for " + item_name + " does not exist.")
#
#func _on_craft_pressed():
	#craft_item("Golden joint")
