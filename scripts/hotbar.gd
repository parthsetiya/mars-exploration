extends Control

var inventory: Node
@onready var grid_container = $GridContainer

func _process(delta):
	inventory = get_node("/root/Inventory")
	update_hotbar()

func update_hotbar():
	var hotbar_items = ["Gold", "Pebble", "Wood"]  # Define the items to show in the hotbar
	for i in range(hotbar_items.size()):
		var item_name = hotbar_items[i]
		var item_button = $HBoxContainer.get_child(i) as Button
		if inventory.items.has(item_name):
			item_button.text = item_name
		else:
			item_button.text = ""

#var selected_item: String = ""
#
#func _on_item_button_pressed(button):
	#selected_item = button.text
	#trigger_animation_for_selected_item()
#
#func trigger_animation_for_selected_item():
	#if selected_item == "item1":
		## Trigger specific animation for item1
		#$Character.play("animation1")
	#elif selected_item == "item2":
		## Trigger specific animation for item2
	#$Character.play("animation2")
