extends Resource

class_name Inventory
var items = []

func get_items():
	return items

func add_item(item_name, quantity=1):
	for item in items:
		if item.name == item_name:
			item.quantity += quantity
			return
	items.append({"name": item_name, "quantity": quantity})
