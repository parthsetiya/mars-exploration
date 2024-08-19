extends Node

var items = {
	
	"Gold": 0,
	"Wood": 0,
	"Amethyst": 0,
	"Golden joint": 0,
	"Stick": 0,
	"Pebble": 0
}

# Adds an item to the inventory
func add_item(item_name: String, amount: int = 1):
	if item_name in items:
		items[item_name] += amount
	else:
		items[item_name] = amount

# Removes an item from the inventory
func remove_item(item_name: String, amount: int = 1):
	if item_name in items:
		items[item_name] -= amount
		if items[item_name] <= 0:
			items.erase(item_name)

# Checks if the inventory has enough items for crafting
func has_enough_items(required_items: Dictionary) -> bool:
	for resource_name in required_items.keys():
		# Convert the string quantity to an integer
		var required_amount = int(required_items[resource_name])
		if !items.has(resource_name) or items[resource_name] < required_amount:
			return false
	return true

# Crafts an item by removing resources and adding the crafted item
func craft_item(required_items: Dictionary, item_name: String) -> bool:
	if has_enough_items(required_items):
		# Remove required resources
		for resource_name in required_items.keys():
			remove_item(resource_name, int(required_items[resource_name]))

		# Add the crafted item
		add_item(item_name, 1)
		return true
	else:
		return false
