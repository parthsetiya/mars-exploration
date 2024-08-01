extends Node2D


@onready var pause_menu = $Player/Camera2D/Pausemenu
var paused = false

@onready var interact_to_read = $Sprite2D/startsignpostarea/interact_to_read

@onready var thiswaytomines = $Sprite2D/thiswaytomines

@onready var start_sign_post_entered = false

var is_showing_thiswaytomines = false

@onready var player = $Player

var playerdata = PlayerData.new()

var inventory = Inventory.new()
@onready var inventory_gui = $Player/Camera2D/InventoryGui
var inv_open = false

const GOLD = preload("res://Inventory/items/gold.tres")
const IRON = preload("res://Inventory/items/iron.tres")
const LOG = preload("res://Inventory/items/log.tres")
# Node definitions
var gold_node
var gold_node2
var iron_node
var tree_node
var inventory_slots
var inventory_gui_slots
var inventory_hotbar_slots
var first_slot_index = null
var second_slot_index = null
var inv_gui_show
var inv_gui_show_hotbar
var iniron
var ingold 
var ingold2
var intree
var ironcollectable = false
var goldcollectable = false
var treecollectable = false
var goldcollectable2 = false

func _ready():
	gold_node = get_node("gold_block")
	gold_node.connect("request_inventory_update", Callable(self, "_on_request_inventory_update"))
	gold_node2 = get_node("gold_block2")
	gold_node2.connect("request_inventory_update", Callable(self, "_on_request_inventory_update"))
	iron_node = get_node("iron_block")
	iron_node.connect("request_inventory_update", Callable(self, "_on_request_inventory_update"))
	tree_node = get_node("tree_block")
	tree_node.connect("request_inventory_update", Callable(self, "_on_request_inventory_update"))
	inventory_gui.connect("slot_clicked", Callable(self, "_on_slot_clicked"))
	inventory_slots = get_node("Player/Camera2D/InventoryGui/GridContainer").get_children()

	inventory_gui_slots = inventory_slots.slice(0, 15)
	inventory_hotbar_slots = inventory_slots.slice(20, 25)
	
	inv_gui_show = get_node("Player/Camera2D/InventoryGui/NinePatchRect")
	inv_gui_show_hotbar = get_node("Player/Camera2D/InventoryGui/NinePatchRect2")
	
	iniron = get_node("iron_block/Area2D")
	ingold = get_node("gold_block/Area2D")
	ingold2 = get_node("gold_block2/Area2D")
	intree = get_node("tree_block/Area2D")
	iniron.connect("body_entered", Callable(self,"inironcollectable"))
	ingold.connect("body_entered", Callable(self,"ingoldcollectable"))
	ingold2.connect("body_entered", Callable(self,"ingoldcollectable"))
	intree.connect("body_entered", Callable(self,"intreecollectable"))
	iniron.connect("body_exited", Callable(self,"leaveironcollectable"))
	ingold.connect("body_exited", Callable(self,"leavegoldcollectable"))
	ingold2.connect("body_exited", Callable(self,"leavegoldcollectable"))
	intree.connect("body_exited", Callable(self,"leavetreecollectable"))
	playerdata.load_data()

func inironcollectable(body):
	ironcollectable = true 

func ingoldcollectable(body):
	goldcollectable = true

func leaveironcollectable(body):
	ironcollectable = false

func leavegoldcollectable(body):
	goldcollectable = false 
	
func intreecollectable(body):
	treecollectable = true

func leavetreecollectable():
	treecollectable = false

func _on_slot_clicked(slot_index):
	if first_slot_index == null:
		first_slot_index = slot_index
	else:
		second_slot_index = slot_index
		_swap_items(first_slot_index, second_slot_index)
		first_slot_index = null
		second_slot_index = null

func _swap_items(slot_index_1, slot_index_2):
	var slot_1 = inventory_slots[slot_index_1]
	var slot_2 = inventory_slots[slot_index_2]

	var item_1 = slot_1.get_children()[1].get_children()[0].get_children()[0]
	var label_1 = slot_1.get_children()[1].get_children()[0].get_children()[1]

	var item_2 = slot_2.get_children()[1].get_children()[0].get_children()[0]
	var label_2 = slot_2.get_children()[1].get_children()[0].get_children()[1]

	var temp_texture = item_1.texture
	var temp_text = label_1.text

	item_1.texture = item_2.texture
	label_1.text = label_2.text

	item_2.texture = temp_texture
	label_2.text = temp_text

	print("Swapped items between slots " + str(slot_index_1) + " and " + str(slot_index_2))

func _on_request_inventory_update(item_name, quantity):
	inventory.add_item(item_name, quantity)
	var updated_quantity = inventory.get_item_quantity(item_name)
	update_inventory_ui(item_name, updated_quantity)
	

func update_inventory_ui(item_name, updated_quantity):
	if ironcollectable and goldcollectable == false:
		playerdata.add_invironingot(1)
		for i in range(inventory_slots.size()):
			var slot = inventory_slots[i]
			if slot.get_child_count() != 0:
				var centre_container = slot.get_children()[1]
				var item = centre_container.get_children()[0].get_children()[0]
				var label = centre_container.get_children()[0].get_children()[1]

				if item.texture == IRON.texture:
					label.text = str(int(label.text) + 1)
					return
					break

		for i in range(inventory_slots.size()):
			var slot = inventory_slots[i]
			if slot.get_children()[1] != null:
				var centre_container = slot.get_children()[1]
				var item = centre_container.get_children()[0].get_children()[0]
				var label = centre_container.get_children()[0].get_children()[1]

				
				if item.texture == null: 
					item.texture = IRON.texture
					label.text = str(int(label.text) + 1)
					return 
					break
					
		for i in range(inventory_slots.size()):
			var slot = inventory_slots[i]
			if slot.get_children()[1] != null:
				var centre_container = slot.get_children()[1]
				var item = centre_container.get_children()[0].get_children()[0]
				var label = centre_container.get_children()[0].get_children()[1]

				
				if item.texture == null: 
					item.texture = IRON.texture
					label.text = str(int(label.text) + 1)
					return
					break 
		
	
	
	if goldcollectable and ironcollectable == false:
		playerdata.add_invGoldIngot(1)
		for i in range(inventory_slots.size()):
			var slot = inventory_slots[i]
			if slot.get_child_count() != 0:
				var centre_container = slot.get_children()[1]
				var item = centre_container.get_children()[0].get_children()[0]
				var label = centre_container.get_children()[0].get_children()[1]

				if item.texture == GOLD.texture:
					label.text = str(int(label.text) + 1)
					return 
					break

		for i in range(inventory_slots.size()):
			var slot = inventory_slots[i]
			if slot.get_children()[1] != null:
				var centre_container = slot.get_children()[1]
				var item = centre_container.get_children()[0].get_children()[0]
				var label = centre_container.get_children()[0].get_children()[1]

				
				if item.texture == null: 
					item.texture = GOLD.texture
					label.text = str(int(label.text) + 1)
					return
					break 
					
		for i in range(inventory_slots.size()):
			var slot = inventory_slots[i]
			if slot.get_children()[1] != null:
				var centre_container = slot.get_children()[1]
				var item = centre_container.get_children()[0].get_children()[0]
				var label = centre_container.get_children()[0].get_children()[1]

				
				if item.texture == null: 
					item.texture = GOLD.texture
					label.text = str(int(label.text) + 1)
					return
					break
	if treecollectable and ironcollectable == false and goldcollectable == false:
		playerdata.add_invGoldIngot(1)
		for i in range(inventory_slots.size()):
			var slot = inventory_slots[i]
			if slot.get_child_count() != 0:
				var centre_container = slot.get_children()[1]
				var item = centre_container.get_children()[0].get_children()[0]
				var label = centre_container.get_children()[0].get_children()[1]

				if item.texture == LOG.texture:
					label.text = str(int(label.text) + 1)
					return 
					break

		for i in range(inventory_slots.size()):
			var slot = inventory_slots[i]
			if slot.get_children()[1] != null:
				var centre_container = slot.get_children()[1]
				var item = centre_container.get_children()[0].get_children()[0]
				var label = centre_container.get_children()[0].get_children()[1]

				
				if item.texture == null: 
					item.texture = LOG.texture
					label.text = str(int(label.text) + 1)
					return
					break 
					
		for i in range(inventory_slots.size()):
			var slot = inventory_slots[i]
			if slot.get_children()[1] != null:
				var centre_container = slot.get_children()[1]
				var item = centre_container.get_children()[0].get_children()[0]
				var label = centre_container.get_children()[0].get_children()[1]

				
				if item.texture == null: 
					item.texture = LOG.texture
					label.text = str(int(label.text) + 1)
					return
					break 
				
		
	
func inventoryopen():
	if inv_open:
		inv_gui_show.hide()
		for slot in inventory_gui_slots:
			slot.hide()
		inv_gui_show_hotbar.hide()
		
	else:
		inv_gui_show.show()
		for slot in inventory_gui_slots:
			slot.show()
		inv_gui_show_hotbar.show()
	inv_open = !inv_open

	
func _process(delta):
	if Input.is_action_just_pressed("Pause"):
		pausemenu()
	if start_sign_post_entered:
		interact_to_read.show()
		if Input.is_action_just_pressed("Interact"):
			if is_showing_thiswaytomines == true:
				thiswaytomines.hide()
				is_showing_thiswaytomines = false
			else:
				interact_to_read.hide()
				thiswaytomines.show()
				is_showing_thiswaytomines = true
	else:
		interact_to_read.hide()
	if Input.is_action_just_pressed("Inventory"):
		inventoryopen()
	
func pausemenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale =  1
	else:
		pause_menu.show()
		Engine.time_scale = 0
		
func _on_startsignpostarea_body_entered(body):
	if body == player:
		start_sign_post_entered = true

func _on_startsignpostarea_body_exited(body):
	if body == player:
		start_sign_post_entered = false
		thiswaytomines.hide()
		is_showing_thiswaytomines = false 


func _on_entrancetogoldmine_body_entered(body):
	if body.name == "Player":
		StageManager.changeStage(StageManager.GOLDMINE, 453, -30)
