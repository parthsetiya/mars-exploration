extends Resource
class_name Inventory
var items = {}


func add_item(item_name, quantity):
	if items.has(item_name):
		items[item_name] + quantity
	else:
		items[item_name] = quantity


func get_items():
	return items

# Gets the quantity of a certain item within the inventory 
func get_item_quantity(item_name):
	if items.has(item_name):
		return items[item_name]
	else:
		return 0

