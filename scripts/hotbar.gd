extends Control

var inventory: Node
@onready var h_box_container = $HBoxContainer

var item_images = {
	"Pebble": preload("res://art/mainart/pebble.png")
	#"gold": preload("res://images/gold.png"),
	#"wood": preload("res://images/wood.png"),
	#"amethyst": preload("res://images/amethyst.png"),
	#"Golden joint": preload("res://images/golden_joint.png")
}

func _process(delta):
	inventory = get_node("/root/Inventory")
	update_hotbar()

func update_hotbar():
	var hotbar_items = ["Pebble", "item2", "item3"]  # Define the items to show in the hotbar
	
	for i in range(hotbar_items.size()):
		var item_name = hotbar_items[i]
		var item_button = h_box_container.get_child(i) as Button
		if inventory.items.has(item_name):
			item_button.text = str(inventory.items[item_name])  # Show the quantity
		else:
			item_button.text = "0"

	# Update textures in the hotbar
	for i in range(hotbar_items.size()):
		var item_name = hotbar_items[i]
		if inventory.items.has(item_name) and item_images.has(item_name):
			var texture_rect = TextureRect.new()
			texture_rect.texture = item_images[item_name]
			texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED  # Ensures the texture fits well
			var container = h_box_container.get_child(i) as Button
			if container:
				container.add_child(texture_rect)
