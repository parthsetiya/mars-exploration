extends Node2D

@onready var pause_menu = $Player/Camera2D/Pausemenu
var paused = false
var playerdata = PlayerData.new()
#var inventory = Inventory.new()
@onready var inventory_gui = $Player/Camera2D/InventoryGui
var inv_open = false
#
#const SELECTEDSLOT = preload("res://art/mainart/selectedslot.tres")
#const DEFAULTSLOT = preload("res://art/mainart/defaultslot.tres")
#const GOLD = preload("res://Inventory/items/gold.tres")
#const IRON = preload("res://Inventory/items/iron.tres")
#const LOG = preload("res://Inventory/items/log.tres")
#const GOLD_STICK = preload("res://art/mainart/gold_stick.tres")
#const GOLD_PICKAXE = preload("res://Inventory/items/gold_pickaxe.tres")

#var inventory_slots
#var inventory_gui_slots
#var inventory_hotbar_slots
#var inv_crafting
#var inventory_crafting
#var first_slot_index = null
#var second_slot_index = null
#var inv_gui_show
#var inv_gui_show_hotbar
#var making_stick = false

func _process(delta):
	if Input.is_action_just_pressed("Pause"):
		pausemenu()
	#if Input.is_action_just_pressed("Inventory"):
		#inventoryopen()
	#for i in range(5):
		#var action_name = "ui_hotbar_" + str(i + 1)  
		#if Input.is_action_just_pressed(action_name):
			#highlight_slot(i)
		#

func pausemenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale =  1
	else:
		pause_menu.show()
		Engine.time_scale = 0
		
	paused = !paused


func _on_area_2d_body_entered(body):
	return


func _ready():
	return
	#inventory_gui.connect("slot_clicked", Callable(self, "_on_slot_clicked"))
	#inventory_slots = get_node("Player/Camera2D/InventoryGui/GridContainer").get_children()
	#inventory_crafting = get_node("Player/Camera2D/InventoryGui/crafting")
	#inventory_crafting.connect("request_inventory_update", Callable(self, "_on_request_inventory_update"))
	##inventory_crafting.connect("request_inventory_update", Callable(self, "remove_inventory_items"))
	#playerdata.connect("inventory_loaded", Callable(self, "_on_inventory_loaded"))


	#inventory_gui_slots = inventory_slots.slice(0, 15)
	#inventory_hotbar_slots = inventory_slots.slice(20, 25) 
	#
	#for slot in inventory_hotbar_slots:
		#if slot.has_node("background"):
			#var slot_background = slot.get_node("background")
			#if slot_background is Sprite2D:
				#slot_background.texture = DEFAULTSLOT.texture 
	 #
	#
	#inv_gui_show = get_node("Player/Camera2D/InventoryGui/NinePatchRect")
	#inv_gui_show_hotbar = get_node("Player/Camera2D/InventoryGui/NinePatchRect2")
	#inv_crafting = get_node("Player/Camera2D/InventoryGui/crafting")
	#
	#playerdata.load_data()
	#
#func _on_slot_clicked(slot_index):
	#if first_slot_index == null:
		#first_slot_index = slot_index
	#else:
		#second_slot_index = slot_index
		#_swap_items(first_slot_index, second_slot_index)
		#first_slot_index = null
		#second_slot_index = null
#
#func _swap_items(slot_index_1, slot_index_2):
	#var slot_1 = inventory_slots[slot_index_1]
	#var slot_2 = inventory_slots[slot_index_2]
#
	#var item_1 = slot_1.get_children()[1].get_children()[0].get_children()[0]
	#var label_1 = slot_1.get_children()[1].get_children()[0].get_children()[1]
#
	#var item_2 = slot_2.get_children()[1].get_children()[0].get_children()[0]
	#var label_2 = slot_2.get_children()[1].get_children()[0].get_children()[1]
#
	#var temp_texture = item_1.texture
	#var temp_text = label_1.text
#
	#item_1.texture = item_2.texture
	#label_1.text = label_2.text
#
	#item_2.texture = temp_texture
	#label_2.text = temp_text
#
	#print("Swapped items between slots " + str(slot_index_1) + " and " + str(slot_index_2))
	
#func _on_request_inventory_update(item_name, quantity):
	#inventory.add_item(item_name, quantity)
	#var updated_quantity = inventory.get_item_quantity(item_name)
	#update_inventory_ui(item_name, updated_quantity)
#
#
#func update_inventory_ui(item_name, updated_quantity):
	#if item_name == IRON.name:
		#playerdata.add_invironingot(1)
		#for slot in inventory_slots:
			#if slot.get_child_count() != 0:
				#var centre_container = slot.get_children()[1]
				#var item = centre_container.get_children()[0].get_children()[0]
				#var label = centre_container.get_children()[0].get_children()[1]
#
				#if item.texture == IRON.texture:
					#label.text = str(int(label.text) + 1)
					#return
#
		#for slot in inventory_slots:
			#if slot.get_child_count() != 0:
				#var centre_container = slot.get_children()[1]
				#var item = centre_container.get_children()[0].get_children()[0]
				#var label = centre_container.get_children()[0].get_children()[1]
#
				#if item.texture == null:
					#item.texture = IRON.texture
					#label.text = str(1)
					#return
#
	#if item_name == GOLD.name:
		#playerdata.add_invGoldIngot(1)
		#for slot in inventory_slots:
			#if slot.get_child_count() != 0:
				#var centre_container = slot.get_children()[1]
				#var item = centre_container.get_children()[0].get_children()[0]
				#var label = centre_container.get_children()[0].get_children()[1]
#
				#if item.texture == GOLD.texture:
					#label.text = str(int(label.text) + 1)
					#return
#
		#for slot in inventory_slots:
			#if slot.get_child_count() != 0:
				#var centre_container = slot.get_children()[1]
				#var item = centre_container.get_children()[0].get_children()[0]
				#var label = centre_container.get_children()[0].get_children()[1]
#
				#if item.texture == null:
					#item.texture = GOLD.texture
					#label.text = str(1)
					#return
#
	#if item_name == LOG.name:
		#playerdata.add_invlogingot(1)
		#for slot in inventory_slots:
			#if slot.get_child_count() != 0:
				#var centre_container = slot.get_children()[1]
				#var item = centre_container.get_children()[0].get_children()[0]
				#var label = centre_container.get_children()[0].get_children()[1]
#
				#if item.texture == LOG.texture:
					#label.text = str(int(label.text) + 1)
					#return
#
		#for slot in inventory_slots:
			#if slot.get_child_count() != 0:
				#var centre_container = slot.get_children()[1]
				#var item = centre_container.get_children()[0].get_children()[0]
				#var label = centre_container.get_children()[0].get_children()[1]
#
				#if item.texture == null:
					#item.texture = LOG.texture
					#label.text = str(1)
					#return
#
#
	#if item_name == GOLD_STICK.name:
		#playerdata.add_invGoldIngot(-2)
		#playerdata.add_invstick(1)
	#if making_stick == true:
		#print("ADDING STICK INTO INVENTORY")
		#for slot in inventory_slots:
			#if slot.get_child_count() != 0:
				#var centre_container = slot.get_children()[1]
				#var item = centre_container.get_children()[0].get_children()[0]
				#var label = centre_container.get_children()[0].get_children()[1]
#
				#if item.texture == GOLD_STICK.texture:
					#label.text = str(int(label.text) + 1)
					#return
				#if item.texture == GOLD.texture:
					#label.text = str(int(label.text) - 2)
#
		#for slot in inventory_slots:
			#if slot.get_child_count() != 0:
				#var centre_container = slot.get_children()[1]
				#var item = centre_container.get_children()[0].get_children()[0]
				#var label = centre_container.get_children()[0].get_children()[1]
#
				#if item.texture == null:
					#item.texture = GOLD_STICK.texture
					#label.text = str(1)
					#return
					#
	#if item_name == GOLD_PICKAXE.name:
		#playerdata.add_invGoldIngot(-3)
		#playerdata.add_invstick(-2)
		#var pickaxe_crafted = false
		#for slot in inventory_slots:
			#if slot.get_child_count() != 0:
				#var centre_container = slot.get_children()[1]
				#var item = centre_container.get_children()[0].get_children()[0]
				#var label = centre_container.get_children()[0].get_children()[1]
				#if item.texture == null and pickaxe_crafted == false:
					#item.texture = GOLD_PICKAXE.texture
					#label.text = str(1)
					#pickaxe_crafted = true
				#if item.texture == GOLD_STICK.texture:
					#label.text = str(int(label.text) - 2) 
					#if label.text == "0":
						#item.texture == null
				#elif item.texture == GOLD.texture:
					#label.text = str(int(label.text) - 3) 
					#if label.text == "0":
						#item.texture = null
						#
#func _on_inventory_loaded(gold_amount, iron_amount, log_amount, stick_amount):
	#for slot in inventory_slots:
		#if slot.get_child_count() != 0:
			#var centre_container = slot.get_children()[1]
			#var item = centre_container.get_children()[0].get_children()[0]
			#var label = centre_container.get_children()[0].get_children()[1]
			#item.texture = null
			#label.text = ""
#
	#if gold_amount > 0:
		#for slot in inventory_slots:
			#if slot.get_child_count() != 0:
				#var centre_container = slot.get_children()[1]
				#var item = centre_container.get_children()[0].get_children()[0]
				#var label = centre_container.get_children()[0].get_children()[1]
#
				#if item.texture == null:
					#item.texture = GOLD.texture
					#label.text = str(gold_amount)
					#break
#
	#if iron_amount > 0:
		#for slot in inventory_slots:
			#if slot.get_child_count() != 0:
				#var centre_container = slot.get_children()[1]
				#var item = centre_container.get_children()[0].get_children()[0]
				#var label = centre_container.get_children()[0].get_children()[1]
#
				#if item.texture == null:
					#item.texture = IRON.texture
					#label.text = str(iron_amount)
					#break
#
	#if log_amount > 0:
		#for slot in inventory_slots:
			#if slot.get_child_count() != 0:
				#var centre_container = slot.get_children()[1]
				#var item = centre_container.get_children()[0].get_children()[0]
				#var label = centre_container.get_children()[0].get_children()[1]
#
				#if item.texture == null:
					#item.texture = LOG.texture
					#label.text = str(log_amount)
					#break
	#
	#if stick_amount > 0:
		#for slot in inventory_slots:
			#if slot.get_child_count() != 0:
				#var centre_container = slot.get_children()[1]
				#var item = centre_container.get_children()[0].get_children()[0]
				#var label = centre_container.get_children()[0].get_children()[1]
#
				#if item.texture == null:
					#item.texture = GOLD_STICK.texture
					#label.text = str(stick_amount)
					#break
		#

	
	#
#func inventoryopen():
	#if inv_open:
		#inv_gui_show.hide()
		#inv_crafting.hide()
		#for slot in inventory_gui_slots:
			#slot.hide()
		#inv_gui_show_hotbar.hide()
		#
	#else:
		#inv_gui_show.show()
		#inv_crafting.show()
		#for slot in inventory_gui_slots:
			#slot.show()
		#inv_gui_show_hotbar.show()
	#inv_open = !inv_open
#
#func highlight_slot(index):
	#for slot in inventory_hotbar_slots:
		#if slot.has_node("background"):
			#var slot_background = slot.get_node("background")
			#if slot_background is Sprite2D:
				#slot_background.texture = DEFAULTSLOT.texture  # Set to default texture
				#
	#if index < inventory_hotbar_slots.size():
		#var selected_slot = inventory_hotbar_slots[index]
		#if selected_slot.has_node("background"):
			#var selected_slot_background = selected_slot.get_node("background")
			#if selected_slot_background is Sprite2D:
				#selected_slot_background.texture = SELECTEDSLOT.texture
