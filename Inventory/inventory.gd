#extends Resource
#
#class_name Inventory
#
#var items = {}
#
#func add_item(item_name, quantity):
	#if items.has(item_name):
		#items[item_name] + quantity
	#else:
		#items[item_name] = quantity
#
#func get_items():
	#return items
#
#func get_item_quantity(item_name):
	#if items.has(item_name):
		#return items[item_name]
	#else:
		#return 0

extends Node

# Dictionary to hold item names and their quantities
var items = {
	"gold": 0,
	"wood": 0,
	"amethyst": 0,
	"Golden joint": 0
}

func add_item(item_name: String, quantity: int = 1):
	print("adding items like a slave")
	print(items)
	if item_name in items:
		items[item_name] += quantity
	else:
		items[item_name] = quantity

func remove_item(item_name: String, quantity: int = 1) -> bool:
	if item_name in items and items[item_name] >= quantity:
		items[item_name] -= quantity
		return true
	return false

func get_item_quantity(item_name: String) -> int:
	if item_name in items:
		return items[item_name]
	return 0

func can_craft(recipe: Dictionary) -> bool:
	for ingredient in recipe.keys():
		if get_item_quantity(ingredient) < recipe[ingredient]:
			return false
	return true

func craft_item(recipe: Dictionary, output_item: String, output_quantity: int = 1) -> bool:
	if can_craft(recipe):
		for ingredient in recipe.keys():
			remove_item(ingredient, recipe[ingredient])
		add_item(output_item, output_quantity)
		return true
	return false
