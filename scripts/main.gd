extends Node2D
class_name Main

@onready var pause_menu = $CanvasLayer/Pausemenu
var paused = false

@onready var interact_to_read = $Sprite2D/startsignpostarea/interact_to_read

@onready var thiswaytomines = $Sprite2D/thiswaytomines

@onready var spaceship_entered = false
@onready var spaceshiparea_2 = $Spaceship/spaceshiparea2
@onready var crashmessage = $spaceship/spaceshiparea/crashmessage
@onready var animation_player = $AnimationPlayer

@onready var recipe_gui = $Player/Camera2D/recipeGui

@onready var start_sign_post_entered = false
var is_showing_thiswaytomines = false
@onready var listofitems = $Control
@onready var tocavemarker = $tocavemarker

@onready var pick_axe_head = $"pick-axe-head"
const PICK_AXE_HEAD = preload("res://Inventory/items/pick-axe-head.tres")
@onready var player = $Player
@onready var alltreefolder = $alltree
@onready var allamethystfolder = $allamethyst
var playerdata = PlayerData.new()
@onready var character_body_2d = $CharacterBody2D
var inventory = Inventory.new()
var playerscript = Player.new()
@onready var inventory_gui = get_node("/root/main/CanvasLayer/InventoryGui")
var inv_open = false
const SELECTEDSLOT = preload("res://art/mainart/selectedslot.tres")
const DEFAULTSLOT = preload("res://art/mainart/defaultslot.tres")
const GOLD = preload("res://Inventory/items/gold.tres")
const IRON = preload("res://Inventory/items/iron.tres")
const LOG = preload("res://Inventory/items/log.tres")
const GOLD_STICK = preload("res://art/mainart/gold_stick.tres")
const GOLD_PICKAXE = preload("res://Inventory/items/gold_pickaxe.tres")
const REMOVE_GOLD = preload("res://Inventory/items/remove_gold.tres")
const WOODEN_PICKAXE = preload("res://Inventory/items/wooden_pickaxe.tres")
const GLOVE = preload("res://Inventory/items/glove.tres")
const GEAR = preload("res://Inventory/items/gear.tres")
const COMPUTER_CHIP = preload("res://Inventory/items/computer_chip.tres")
const METAL_PLATE = preload("res://Inventory/items/metal_plate.tres")
const REMOVE_PARTS = preload("res://Inventory/items/remove_parts.tres")
const REMOVEFROMNPC = preload("res://Inventory/items/removefromnpc.tres")
const AMETHYST = preload("res://Inventory/items/amethyst.tres")
@onready var marker_2d_2 = $Area2D2/Marker2D2
@onready var marker_2d = $areaback/Marker2D
@onready var allgoldfolder = $allgold
@onready var allironfolder = $alliron
@onready var cavetomainmarker = $cavetomainmarker
var player_in_collect_pick_axe_head_area = false
const AMETHYST_GEAR = preload("res://Inventory/items/amethyst_gear.tres")
const COBALT_GEAR = preload("res://Inventory/items/cobalt_gear.tres")
const GOLD_GEAR = preload("res://Inventory/items/gold_gear.tres")
const OIL = preload("res://Inventory/items/oil.tres")
const TOOLBOX = preload("res://Inventory/items/toolbox.tres")
const TOOLKIT = preload("res://Inventory/items/toolkit.tres")
const WIRES = preload("res://Inventory/items/wires.tres")

# Node definitions
var gold_node
var gold_node2
var iron_node
var tree_node
var remove_gold
var inventory_slots
var inventory_gui_slots
var inventory_hotbar_slots
var inv_crafting
var inventory_crafting
var first_slot_index = null
var second_slot_index = null
var inv_gui_show
var inv_gui_show_hotbar
var recipe_gui_show
var iniron
var ingold 
var ingold2
var intree
var ironcollectable = false
var goldcollectable = false
var treecollectable = false
var goldcollectable2 = false
var making_stick = false
var slotonetexture
var collectediron = false
var npc
var housealien
var alliron
var allgold
var alltree
var allamethyst
var player_node
var playerholding_pick = false
var blacksmithshop
signal player_holding_pick


func _ready():
	allgold = allgoldfolder.get_children()
	alliron = allironfolder.get_children()
	alltree = alltreefolder.get_children()
	allamethyst = allamethystfolder.get_children()
	for gold in allgold:
		gold.connect("request_inventory_update", Callable(self, "_on_request_inventory_update"))
	for iron in alliron:
		iron.connect("request_inventory_update", Callable(self, "_on_request_inventory_update"))
	for tree in alltree:
		tree.connect("request_inventory_update", Callable(self, "_on_request_inventory_update"))
	for amethyst in allamethyst:
		amethyst.connect("request_inventory_update", Callable(self, "_on_request_inventory_update"))
	tree_node = get_node("tree_block")
	tree_node.connect("request_inventory_update", Callable(self, "_on_request_inventory_update"))
	inventory_gui.connect("slot_clicked", Callable(self, "_on_slot_clicked"))
	inventory_slots = get_node("/root/main/CanvasLayer/InventoryGui/GridContainer").get_children()
	inventory_crafting = get_node("/root/main/CanvasLayer/InventoryGui/crafting")
	inventory_crafting.connect("request_inventory_update", Callable(self, "_on_request_inventory_update"))
	#inventory_crafting.connect("request_inventory_update", Callable(self, "remove_inventory_items"))
	playerdata.connect("inventory_loaded", Callable(self, "_on_inventory_loaded"))
	npc = get_node("CharacterBody2D")
	npc.connect("request_inventory_update", Callable(self, "_on_request_inventory_update"))
	housealien = get_node("housealien")
	housealien.connect("request_inventory_update", Callable(self, "_on_request_inventory_update"))
	player_node = get_node("Player")
	blacksmithshop = get_node("blacksmith/blacksmithshop")
	blacksmithshop.connect("request_inventory_update", Callable(self, "_on_request_inventory_update"))
	inventory_gui_slots = inventory_slots.slice(0, 15)
	inventory_hotbar_slots = inventory_slots.slice(20, 25) 
	
	for slot in inventory_hotbar_slots:
		if slot.has_node("background"):
			var slot_background = slot.get_node("background")
			if slot_background is Sprite2D:
				slot_background.texture = DEFAULTSLOT.texture 
	 
	
	inv_gui_show = get_node("/root/main/CanvasLayer/InventoryGui/NinePatchRect")
	inv_gui_show_hotbar = get_node("/root/main/CanvasLayer/InventoryGui/NinePatchRect2")
	inv_crafting = get_node("/root/main/CanvasLayer/InventoryGui/crafting")
	recipe_gui_show = get_node("Player/Camera2D/crafting")
	playerdata.load_data()
	playerdata.SavePos = player.position
	
	
	
	



#func inironcollectable(body):
	#ironcollectable = true 
#
#func ingoldcollectable(body):
	#goldcollectable = true
#
#func leaveironcollectable(body):
	#ironcollectable = false
#
#func leavegoldcollectable(body):
	#goldcollectable = false 
	#
#func intreecollectable(body):
	#treecollectable = true
#
#func leavetreecollectable():
	#treecollectable = false
#
#func crafted_stick():
	#
	#print("running add gold")
	#making_stick = true
	#treecollectable = false
	#goldcollectable = false
	#goldcollectable2 = false
	#ironcollectable = false
	#_on_request_inventory_update(GOLD_STICK, 1)
	#making_stick = false
	

func _on_slot_clicked(slot_index):
	if first_slot_index == null:
		first_slot_index = slot_index
	else:
		second_slot_index = slot_index
		_swap_items(first_slot_index, second_slot_index)
		first_slot_index = null
		second_slot_index = null

func _swap_items(slot_index_1, slot_index_2):
	if inv_open == false:
		return
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
	print("adding ", item_name, quantity)
	inventory.add_item(item_name, quantity)
	var updated_quantity = inventory.get_item_quantity(item_name)
	update_inventory_ui(item_name, updated_quantity)


func update_inventory_ui(item_name, updated_quantity):
	if item_name == IRON.name:
		playerdata.add_invironingot(1)
		for slot in inventory_slots:
			if slot.get_child_count() != 0:
				var centre_container = slot.get_children()[1]
				var item = centre_container.get_children()[0].get_children()[0]
				var label = centre_container.get_children()[0].get_children()[1]

				if item.texture == IRON.texture:
					label.text = str(int(label.text) + 1)
					return

		for slot in inventory_slots:
			if slot.get_child_count() != 0:
				var centre_container = slot.get_children()[1]
				var item = centre_container.get_children()[0].get_children()[0]
				var label = centre_container.get_children()[0].get_children()[1]

				if item.texture == null:
					item.texture = IRON.texture
					label.text = str(1)
					return

	if item_name == AMETHYST.name:
		playerdata.add_invironingot(1)
		for slot in inventory_slots:
			if slot.get_child_count() != 0:
				var centre_container = slot.get_children()[1]
				var item = centre_container.get_children()[0].get_children()[0]
				var label = centre_container.get_children()[0].get_children()[1]

				if item.texture == AMETHYST.texture:
					label.text = str(int(label.text) + 1)
					return

		for slot in inventory_slots:
			if slot.get_child_count() != 0:
				var centre_container = slot.get_children()[1]
				var item = centre_container.get_children()[0].get_children()[0]
				var label = centre_container.get_children()[0].get_children()[1]

				if item.texture == null:
					item.texture = AMETHYST.texture
					label.text = str(1)
					return
	if item_name == GOLD.name:
		playerdata.add_invGoldIngot(1)
		for slot in inventory_slots:
			if slot.get_child_count() != 0:
				var centre_container = slot.get_children()[1]
				var item = centre_container.get_children()[0].get_children()[0]
				var label = centre_container.get_children()[0].get_children()[1]

				if item.texture == GOLD.texture:
					item.show()
					label.show()
					label.text = str(int(label.text) + 1)
					return

		for slot in inventory_slots:
			if slot.get_child_count() != 0:
				var centre_container = slot.get_children()[1]
				var item = centre_container.get_children()[0].get_children()[0]
				var label = centre_container.get_children()[0].get_children()[1]

				if item.texture == null:
					item.texture = GOLD.texture
					label.text = str(1)
					return

	if item_name == LOG.name:
		playerdata.add_invlogingot(1)
		for slot in inventory_slots:
			if slot.get_child_count() != 0:
				var centre_container = slot.get_children()[1]
				var item = centre_container.get_children()[0].get_children()[0]
				var label = centre_container.get_children()[0].get_children()[1]

				if item.texture == LOG.texture:
					label.text = str(int(label.text) + 1)
					return

		for slot in inventory_slots:
			if slot.get_child_count() != 0:
				var centre_container = slot.get_children()[1]
				var item = centre_container.get_children()[0].get_children()[0]
				var label = centre_container.get_children()[0].get_children()[1]

				if item.texture == null:
					item.texture = LOG.texture
					label.text = str(1)
					return


	if item_name == GOLD_STICK.name:
		playerdata.add_invGoldIngot(-2)
		playerdata.add_invstick(1)
		print("ADDING STICK INTO INVENTORY")
		for slot in inventory_slots:
			if slot.get_child_count() != 0:
				var centre_container = slot.get_children()[1]
				var item = centre_container.get_children()[0].get_children()[0]
				var label = centre_container.get_children()[0].get_children()[1]

				if item.texture == GOLD_STICK.texture:
					label.text = str(int(label.text) + 1)
					return
				if item.texture == GOLD.texture:
					label.text = str(int(label.text) - 2)

		for slot in inventory_slots:
			if slot.get_child_count() != 0:
				var centre_container = slot.get_children()[1]
				var item = centre_container.get_children()[0].get_children()[0]
				var label = centre_container.get_children()[0].get_children()[1]

				if item.texture == null:
					item.texture = GOLD_STICK.texture
					label.text = str(1)
					return
					
	if item_name == GOLD_PICKAXE.name:
		playerdata.add_pickaxe(1)
		playerdata.add_invstick(-1)
		playerdata.add_pickaxehead(-1)
		var pickaxe_crafted = false
		for slot in inventory_slots:
			if slot.get_child_count() != 0:
				var centre_container = slot.get_children()[1]
				var item = centre_container.get_children()[0].get_children()[0]
				var label = centre_container.get_children()[0].get_children()[1]
				if item.texture == null and pickaxe_crafted == false:
					item.texture = GOLD_PICKAXE.texture
					label.text = str(1)
					pickaxe_crafted = true
				if item.texture == GOLD_STICK.texture:
					label.text = str(int(label.text) - 1) 
					if label.text == "0":
						item.texture == null
				elif item.texture == PICK_AXE_HEAD.texture:
					label.text = str(int(label.text) - 1) 
					if label.text == "0":
						item.texture = null
						
	if item_name == WOODEN_PICKAXE.name:
		playerdata.add_invlogingot(-3)
		playerdata.add_invstick(-2)
		var pickaxe_crafted = false
		for slot in inventory_slots:
			if slot.get_child_count() != 0:
				var centre_container = slot.get_children()[1]
				var item = centre_container.get_children()[0].get_children()[0]
				var label = centre_container.get_children()[0].get_children()[1]
				if item.texture == null and pickaxe_crafted == false:
					item.texture = WOODEN_PICKAXE.texture
					label.text = str(1)
					pickaxe_crafted = true
				if item.texture == GOLD_STICK.texture:
					label.text = str(int(label.text) - 2) 
					if label.text == "0":
						item.texture == null
				elif item.texture == LOG.texture:
					label.text = str(int(label.text) - 3) 
					if label.text == "0":
						item.texture = null
						
	if item_name == REMOVE_GOLD.name:
		playerdata.add_invGoldIngot(-2)
		print("removing gold which has been taken by jhao")
		for slot in inventory_slots:
			if slot.get_child_count() != 0:
				var centre_container = slot.get_children()[1]
				var item = centre_container.get_children()[0].get_children()[0]
				var label = centre_container.get_children()[0].get_children()[1]
				if item.texture == GOLD.texture:
					label.text = str(int(label.text) - 2)
					if int(label.text) == 0:
						item.hide()
						label.hide()
	if item_name == GLOVE.name:
		print("ASDFASDFASFDASFD")
		for slot in inventory_slots:
			if slot.get_child_count() != 0:
				var centre_container = slot.get_children()[1]
				var item = centre_container.get_children()[0].get_children()[0]
				var label = centre_container.get_children()[0].get_children()[1]

				if item.texture == GLOVE.texture:
					label.text = str(int(label.text) + 1)
					return

		for slot in inventory_slots:
			if slot.get_child_count() != 0:
				var centre_container = slot.get_children()[1]
				var item = centre_container.get_children()[0].get_children()[0]
				var label = centre_container.get_children()[0].get_children()[1]

				if item.texture == null:
					item.texture = GLOVE.texture
					label.text = str(1)
					return
					
	if item_name == GEAR.name:
		playerdata.add_invGoldIngot(-4)
		playerdata.add_invironingot(-6)
		for slot in inventory_slots:
			if slot.get_child_count() != 0:
				var centre_container = slot.get_children()[1]
				var item = centre_container.get_children()[0].get_children()[0]
				var label = centre_container.get_children()[0].get_children()[1]

				if item.texture == GEAR.texture:
					label.text = str(int(label.text) + 1)
					return
				if item.texture == GOLD.texture:
					label.text = str(int(label.text) - 4)
				if item.texture == IRON.texture:
					label.text = str(int(label.text) - 6)

		for slot in inventory_slots:
			if slot.get_child_count() != 0:
				var centre_container = slot.get_children()[1]
				var item = centre_container.get_children()[0].get_children()[0]
				var label = centre_container.get_children()[0].get_children()[1]

				if item.texture == null:
					item.texture = GEAR.texture
					label.text = str(1)
					return
	if item_name == PICK_AXE_HEAD.name:
		playerdata.add_pickaxehead(1)
		for slot in inventory_slots:
			if slot.get_child_count() != 0:
				var centre_container = slot.get_children()[1]
				var item = centre_container.get_children()[0].get_children()[0]
				var label = centre_container.get_children()[0].get_children()[1]

				if item.texture == PICK_AXE_HEAD.texture:
					label.text = str(int(label.text) + 1)
					return

		for slot in inventory_slots:
			if slot.get_child_count() != 0:
				var centre_container = slot.get_children()[1]
				var item = centre_container.get_children()[0].get_children()[0]
				var label = centre_container.get_children()[0].get_children()[1]

				if item.texture == null:
					item.texture = PICK_AXE_HEAD.texture
					label.text = str(1)
					return
	if item_name == REMOVE_PARTS.name:
		print("REMOVING ITEMS")
		for slot in inventory_slots:
			if slot.get_child_count() != 0:
				var centre_container = slot.get_children()[1]
				var item = centre_container.get_children()[0].get_children()[0]
				var label = centre_container.get_children()[0].get_children()[1]
				if item.texture == COMPUTER_CHIP.texture:
					label.text = str(int(label.text) - playerdata.invcomputerchip)
					if int(label.text) <= 0:
						label.text = null
						item.texture = null
				if item.texture == TOOLKIT.texture:
					label.text = str(int(label.text) - playerdata.invtoolkit)
					if int(label.text) <= 0:
						label.text = null
						item.texture = null
				if item.texture == TOOLBOX.texture:
					label.text = str(int(label.text) - playerdata.invtoolbox)
					if int(label.text) <= 0:
						label.text = null
						item.texture = null
				if item.texture == OIL.texture:
					label.text = str(int(label.text) - playerdata.invoil)
					if int(label.text) <= 0:
						label.text = null
						item.texture = null
				if item.texture == METAL_PLATE.texture:
					label.text = str(int(label.text) - playerdata.invmetalplate)
					if int(label.text) <= 0:
						label.text = null
						item.texture = null
				if item.texture == GOLD_GEAR.texture: 
					label.text = str(int(label.text) - playerdata.invgoldgear)
					if int(label.text) <= 0:
						label.text = null
						item.texture = null
				if item.texture == COBALT_GEAR.texture:
					label.text = str(int(label.text) - playerdata.invcobaltgear)
					if int(label.text) <= 0:
						label.text = null
						item.texture = null
				if item.texture == AMETHYST_GEAR.texture:
					label.text = str(int(label.text) - playerdata.invamethystgear)
					if int(label.text) <= 0:
						label.text = null
						item.texture = null
				if item.texture == WIRES.texture:
					label.text = str(int(label.text) - playerdata.invwires)
					if int(label.text) <= 0:
						label.text = null
						item.texture = null
	if item_name == REMOVEFROMNPC.name:
		playerdata.add_invGoldIngot(-5)
		playerdata.add_invironingot(-5)
		for slot in inventory_slots:
			if slot.get_child_count() != 0:
				var centre_container = slot.get_children()[1]
				var item = centre_container.get_children()[0].get_children()[0]
				var label = centre_container.get_children()[0].get_children()[1]
				if item.texture == GOLD.texture:
					label.text = str(int(label.text) - 5)
					if int(label.text) <= 0:
						item.texture = null
						label.text = null
				if item.texture == IRON.texture:
					label.text = str(int(label.text) - 5)
					if int(label.text) <= 0:
						item.texture = null
						label.text = null

	
func _on_inventory_loaded(gold_amount, iron_amount, log_amount, stick_amount, amethyst_amount, pick_axe_head_amount, pick_axe_amount, toolbox_amount, toolkit_amount, wires_amount, oil_amount, gold_gear_amount, amethyst_gear_amount, cobalt_gear_amount, metal_plate_amount, computer_chip_amount):
	for slot in inventory_slots:
		if slot.get_child_count() != 0:
			var centre_container = slot.get_children()[1]
			var item = centre_container.get_children()[0].get_children()[0]
			var label = centre_container.get_children()[0].get_children()[1]
			item.texture = null
			label.text = ""

	if gold_amount > 0:
		for slot in inventory_slots:
			if slot.get_child_count() != 0:
				var centre_container = slot.get_children()[1]
				var item = centre_container.get_children()[0].get_children()[0]
				var label = centre_container.get_children()[0].get_children()[1]

				if item.texture == null:
					item.texture = GOLD.texture
					label.text = str(gold_amount)
					break

	if iron_amount > 0:
		for slot in inventory_slots:
			if slot.get_child_count() != 0:
				var centre_container = slot.get_children()[1]
				var item = centre_container.get_children()[0].get_children()[0]
				var label = centre_container.get_children()[0].get_children()[1]

				if item.texture == null:
					item.texture = IRON.texture
					label.text = str(iron_amount)
					break

	if log_amount > 0:
		for slot in inventory_slots:
			if slot.get_child_count() != 0:
				var centre_container = slot.get_children()[1]
				var item = centre_container.get_children()[0].get_children()[0]
				var label = centre_container.get_children()[0].get_children()[1]

				if item.texture == null:
					item.texture = LOG.texture
					label.text = str(log_amount)
					break
	
	if stick_amount > 0:
		for slot in inventory_slots:
			if slot.get_child_count() != 0:
				var centre_container = slot.get_children()[1]
				var item = centre_container.get_children()[0].get_children()[0]
				var label = centre_container.get_children()[0].get_children()[1]

				if item.texture == null:
					item.texture = GOLD_STICK.texture
					label.text = str(stick_amount)
					break
	if amethyst_amount > 0:
		for slot in inventory_slots:
			if slot.get_child_count() != 0:
				var centre_container = slot.get_children()[1]
				var item = centre_container.get_children()[0].get_children()[0]
				var label = centre_container.get_children()[0].get_children()[1]

				if item.texture == null:
					item.texture = AMETHYST.texture
					label.text = str(amethyst_amount)
					break
					
	if pick_axe_head_amount > 0:
		for slot in inventory_slots:
			if slot.get_child_count() != 0:
				var centre_container = slot.get_children()[1]
				var item = centre_container.get_children()[0].get_children()[0]
				var label = centre_container.get_children()[0].get_children()[1]

				if item.texture == null:
					item.texture = PICK_AXE_HEAD.texture
					label.text = str(pick_axe_head_amount)
					break

	if pick_axe_amount > 0:
		for slot in inventory_slots:
			if slot.get_child_count() != 0:
				var centre_container = slot.get_children()[1]
				var item = centre_container.get_children()[0].get_children()[0]
				var label = centre_container.get_children()[0].get_children()[1]

				if item.texture == null:
					item.texture = GOLD_PICKAXE.texture
					label.text = str(pick_axe_amount)
					break

	if toolbox_amount > 0:
		for slot in inventory_slots:
			if slot.get_child_count() != 0:
				var centre_container = slot.get_children()[1]
				var item = centre_container.get_children()[0].get_children()[0]
				var label = centre_container.get_children()[0].get_children()[1]

				if item.texture == null:
					item.texture = TOOLBOX.texture
					label.text = str(toolbox_amount)
					break

	if toolkit_amount > 0:
		for slot in inventory_slots:
			if slot.get_child_count() != 0:
				var centre_container = slot.get_children()[1]
				var item = centre_container.get_children()[0].get_children()[0]
				var label = centre_container.get_children()[0].get_children()[1]

				if item.texture == null:
					item.texture = TOOLKIT.texture
					label.text = str(toolkit_amount)
					break

	if wires_amount > 0:
		for slot in inventory_slots:
			if slot.get_child_count() != 0:
				var centre_container = slot.get_children()[1]
				var item = centre_container.get_children()[0].get_children()[0]
				var label = centre_container.get_children()[0].get_children()[1]

				if item.texture == null:
					item.texture = WIRES.texture
					label.text = str(wires_amount)
					break

	if oil_amount > 0:
		for slot in inventory_slots:
			if slot.get_child_count() != 0:
				var centre_container = slot.get_children()[1]
				var item = centre_container.get_children()[0].get_children()[0]
				var label = centre_container.get_children()[0].get_children()[1]

				if item.texture == null:
					item.texture = OIL.texture
					label.text = str(oil_amount)
					break

	if gold_gear_amount > 0:
		for slot in inventory_slots:
			if slot.get_child_count() != 0:
				var centre_container = slot.get_children()[1]
				var item = centre_container.get_children()[0].get_children()[0]
				var label = centre_container.get_children()[0].get_children()[1]

				if item.texture == null:
					item.texture = GOLD_GEAR.texture
					label.text = str(gold_gear_amount)
					break

	if amethyst_gear_amount > 0:
		for slot in inventory_slots:
			if slot.get_child_count() != 0:
				var centre_container = slot.get_children()[1]
				var item = centre_container.get_children()[0].get_children()[0]
				var label = centre_container.get_children()[0].get_children()[1]

				if item.texture == null:
					item.texture = AMETHYST_GEAR.texture
					label.text = str(amethyst_gear_amount)
					break

	if cobalt_gear_amount > 0:
		for slot in inventory_slots:
			if slot.get_child_count() != 0:
				var centre_container = slot.get_children()[1]
				var item = centre_container.get_children()[0].get_children()[0]
				var label = centre_container.get_children()[0].get_children()[1]

				if item.texture == null:
					item.texture = COBALT_GEAR.texture
					label.text = str(cobalt_gear_amount)
					break
					
	if metal_plate_amount> 0:
		for slot in inventory_slots:
			if slot.get_child_count() != 0:
				var centre_container = slot.get_children()[1]
				var item = centre_container.get_children()[0].get_children()[0]
				var label = centre_container.get_children()[0].get_children()[1]

				if item.texture == null:
					item.texture = METAL_PLATE.texture
					label.text = str(cobalt_gear_amount)
					break
					
	if computer_chip_amount > 0:
		for slot in inventory_slots:
			if slot.get_child_count() != 0:
				var centre_container = slot.get_children()[1]
				var item = centre_container.get_children()[0].get_children()[0]
				var label = centre_container.get_children()[0].get_children()[1]

				if item.texture == null:
					item.texture = COMPUTER_CHIP.texture
					label.text = str(cobalt_gear_amount)
					break

		

	
	
func inventoryopen():
	if inv_open:
		inv_gui_show.hide()
		inv_crafting.hide()
		for slot in inventory_gui_slots:
			slot.hide()

		
	else:
		inv_gui_show.show()
		inv_crafting.show()
		for slot in inventory_gui_slots:
			slot.show()
	inv_open = !inv_open

	
func _process(delta):
	if Input.is_action_just_pressed("Pause"):
		pausemenu()
	if Input.is_action_just_pressed("Inventory"):
		inventoryopen()
	for i in range(5):
		var action_name = "ui_hotbar_" + str(i + 1)  
		if Input.is_action_just_pressed(action_name):
			highlight_slot(i)
	if Input.is_action_just_pressed("craftinglist"):
		if not recipe_gui.visible:
			recipe_gui.show()
		else:
			recipe_gui.hide()
	if playerdata.current_item == str(GOLD_PICKAXE.texture):
		playerscript.playerholdingpick = true
	
	if player_in_collect_pick_axe_head_area == true && Input.is_action_just_pressed("g"):
		_on_request_inventory_update(PICK_AXE_HEAD.name, 1)
		pick_axe_head.queue_free()
	if spaceship_entered == true && Input.is_action_just_pressed("g"):
		deposititems()
		
		

		
		

func deposititems():
	_on_request_inventory_update(REMOVE_PARTS.name, 1)
	playerdata.add_spaceship_computer_chip(playerdata.invcomputerchip)
	playerdata.add_spaceship_machine_parts(playerdata.invtoolkit)
	playerdata.add_spaceship_thruster_repair_kits(playerdata.invtoolbox)
	playerdata.add_spaceship_carton_of_oil(playerdata.invoil)
	playerdata.add_spaceship_metal_plates(playerdata.invmetalplate)
	playerdata.add_spaceship_gold_gears(playerdata.invgoldgear)
	playerdata.add_spaceship_cobalt_gears(playerdata.invcobaltgear)
	playerdata.add_spaceship_amethyst_gears(playerdata.invamethystgear)
	playerdata.add_spaceship_wires(playerdata.invwires)
	playerdata.add_computerchip(-1 * playerdata.invcomputerchip)
	playerdata.add_toolkit(-1 * playerdata.invtoolkit)
	playerdata.add_toolbox(-1 * playerdata.invtoolbox)
	playerdata.add_oil(-1 * playerdata.invoil)
	playerdata.add_metalplate(-1 * playerdata.invmetalplate)
	playerdata.add_goldgear(-1 * playerdata.invgoldgear)
	playerdata.add_cobaltgear(-1 * playerdata.invcobaltgear)
	playerdata.add_amethystgear(-1 * playerdata.invamethystgear)
	playerdata.add_wires(-1 * playerdata.invwires)
	


func highlight_slot(index):
	for slot in inventory_hotbar_slots:
		if slot.has_node("background"):
			var slot_background = slot.get_node("background")
			if slot_background is Sprite2D:
				slot_background.texture = DEFAULTSLOT.texture
				
	if index < inventory_hotbar_slots.size():
		var selected_slot = inventory_hotbar_slots[index]
		if selected_slot.get_child_count() != 0:
			var centre_container = selected_slot.get_children()[1]
			var item = centre_container.get_children()[0].get_children()[0]
			if item.texture != null:
				if selected_slot.has_node("background"):
					var selected_slot_background = selected_slot.get_node("background")
					if selected_slot_background is Sprite2D:
						selected_slot_background.texture = SELECTEDSLOT.texture
				playerdata.updatecurrent_item(str(item.texture))
			else: 
				playerdata.updatecurrent_item("")


			

	
	
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



func _on_area_2d_body_entered(body):
	if body.name == "Player":
		StageManager.changeStage(StageManager.HOUSETEST, 453, -30)
		

func _on_spaceshiparea_body_entered(body):
	if body == player:
		spaceship_entered = true
		listofitems.show()


func _on_spaceshiparea_body_exited(body):
	if body == player:
		spaceship_entered = false
		listofitems.hide()




func _on_areaback_body_entered(body):
	if body == player:
		player.speed = 0 
		animation_player.play("fadein")
		player.global_position = marker_2d.global_position
		var camera = $Player/Camera2D 
		if camera:
			camera.limit_right = 2600 
			camera.limit_left = -2600
			camera.limit_bottom = 1000
			camera.limit_top = -1800
		animation_player.play("fadeout")
		await get_tree().create_timer(1).timeout
		player.speed = 100


func _on_area_2d_2_body_entered(body):
	if body == player:
		player.speed = 0
		animation_player.play("fadein")  
		player.global_position = marker_2d_2.global_position
		var camera = $Player/Camera2D 
		if camera:
			camera.limit_right = 10000 
			camera.limit_left = 5400
		animation_player.play("fadeout") 
		await get_tree().create_timer(1).timeout
		player.speed = 100
 




func _on_tocave_body_entered(body):
	if body == player:
		player.speed = 0 
		animation_player.play("fadein")
		player.global_position = tocavemarker.global_position
		animation_player.play("fadeout")
		var camera = $Player/Camera2D 
		if camera:
			camera.limit_right = 100000
			camera.limit_left = -40000
			camera.limit_bottom = 10000 
			camera.limit_top = -100000
		await get_tree().create_timer(1).timeout
		player.speed = 100
		
		

func _on_cavetomain_body_exited(body):
	if body == player: 
		player.speed = 0
		animation_player.play("fadein")
		player.global_position = cavetomainmarker.global_position
		animation_player.play("fadeout")
		var camera = $Player/Camera2D 
		if camera:
			camera.limit_right = 2600 
			camera.limit_left = -2000
			camera.limit_bottom = 1000
			camera.limit_top = -1800
		await get_tree().create_timer(1).timeout
		
		player.speed = 100





func _on_pickaxearea_body_entered(body):
	if body == player:
		player_in_collect_pick_axe_head_area = true


func _on_pickaxearea_body_exited(body):
		if body == player:
			player_in_collect_pick_axe_head_area = false


func _on_area_2d_3_body_entered(body):
	if body == player:
		var camera = $Player/Camera2D
		if camera:
			camera.limit_right = 2600 
			camera.limit_left = -2000
			camera.limit_bottom = 1000
			camera.limit_top = -1800


func _on_area_2d_4_body_entered(body):
	if body == player:
		var camera = $Player/Camera2D
		if camera:
			camera.limit_right = 10000 
			camera.limit_left = 5400
			camera.limit_bottom = 1000
			camera.limit_top = -1800
