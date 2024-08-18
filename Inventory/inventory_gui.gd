extends Control

var inventory: Node

func _process(delta):
	inventory = get_node("/root/Inventory")  
	update_inventory_display()

func update_inventory_display():
	var inventory_text = ""
	for item in inventory.items.keys():
		inventory_text += item + ": " + str(inventory.items[item]) + "\n"
	
	$InventoryLabel.text = inventory_text  



var recipes = {
	"Stick": {"Wood": "2"},
	"Golden joint": {"Stick": "1", "Gold": "4"}
}

func craft_item(item_name: String):
	if item_name in recipes.keys():
		if inventory.craft_item(recipes[item_name], item_name):
			update_inventory_display()
		else:
			print("Not enough resources to craft " + item_name)

func _on_craft_pressed():
	print("crafint joint")
	craft_item("Golden joint")


func _on_stick_pressed():
	craft_item("Stick")
