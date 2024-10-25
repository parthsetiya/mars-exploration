extends Node2D
class_name Main
@onready var pause_menu = $CanvasLayer/Pausemenu
var paused = false
@onready var music = $AudioStreamPlayer
@onready var cavemusic = $AudioStreamPlayer2
@onready var animation_rocket = $AnimationPlayer
var screen_shake_strength = 10  
var fade_duration = 1.0  
var move_speed = 200  
var exit_delay = 2.0  
var player_exit_position = Vector2(-500, -500)
@onready var interact_to_read = $Sprite2D/startsignpostarea/interact_to_read
@onready var maprough = $CanvasLayer/maprough
@onready var thiswaytomines = $Sprite2D/thiswaytomines
@onready var spaceship = $spaceship
@onready var spaceship_entered = false
@onready var spaceshiparea_2 = $Spaceship/spaceshiparea2
@onready var crashmessage = $spaceship/spaceshiparea/crashmessage
@onready var animation_player = $AnimationPlayer
const SPACESHIPFINISH = preload("res://art/spaceshipfinish.tres")
@onready var recipe_gui = $Player/Camera2D/recipeGui
var mapshow = false
@onready var start_sign_post_entered = false
var is_showing_thiswaytomines = false
@onready var listofitems = $Control
@onready var tocavemarker = $tocavemarker
@onready var pick_axe_head = $"pick-axe-head"
@onready var player = $Player
@onready var alltreefolder = $alltree
@onready var allamethystfolder = $allamethyst
var playerdata = PlayerData.new()
@onready var character_body_2d = $CharacterBody2D
var inventory = Inventory.new()
var playerscript = Player.new()
var lock = false
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
const COMPUTER_CHIP = preload("res://Inventory/items/computer_chip.tres")
const REMOVE_PARTS = preload("res://Inventory/items/remove_parts.tres")
const REMOVEFROMNPC = preload("res://Inventory/items/removefromnpc.tres")
const AMETHYST = preload("res://Inventory/items/amethyst.tres")
@onready var marker_2d_2 = $Area2D2/Marker2D2
@onready var marker_2d = $areaback/Marker2D
@onready var allgoldfolder = $allgold
@onready var allironfolder = $alliron
@onready var cavetomainmarker = $cavetomainmarker
@onready var rich_text_label = $CanvasLayer/RichTextLabel
var player_in_collect_pick_axe_head_area = false
const AMETHYST_GEAR = preload("res://Inventory/items/amethyst_gear.tres")
const COBALT_GEAR = preload("res://Inventory/items/cobalt_gear.tres")
const GOLD_GEAR = preload("res://Inventory/items/gold_gear.tres")
const OIL = preload("res://Inventory/items/oil.tres")
const TOOLBOX = preload("res://Inventory/items/toolbox.tres")
const TOOLKIT = preload("res://Inventory/items/toolkit.tres")
const WIRES = preload("res://Inventory/items/wires.tres")
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
signal player_holding_pick
@onready var blacksmithshop = $blacksmithshop
@onready var electricianshop = $electricianshop


#Declares all of the external files using get_nodes which allows signals to be connected, as well as declaring other variables to be used in the script. 
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
	player_node = get_node("Player")
	blacksmithshop.connect("request_inventory_update", Callable(self, "_on_request_inventory_update"))
	electricianshop.connect("request_inventory_update", Callable(self, "_on_request_inventory_update"))
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
	
	var canvas_modulate = $CanvasModulate2
	canvas_modulate.color = Color(1, 1, 1, 1) 
	
	
# Allows items to be swapped between slots
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
	if slot_1.get_child_count() != 0 and slot_2.get_child_count() !=0:
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


# Called from other files via a signal, this causes the update_inventory to be run, hence causing a change in the playerdata values and the frontend of the inventory. 
func _on_request_inventory_update(item_name, quantity):
	print("adding ", item_name, quantity)
	inventory.add_item(item_name, quantity)
	var updated_quantity = inventory.get_item_quantity(item_name)
	update_inventory_ui(item_name, updated_quantity)


func update_inventory_ui(item_name, updated_quantity):
	if item_name == IRON.name:
		playerdata.add_invironingot(1)
		playerdata.load_data()

	if item_name == AMETHYST.name:
		playerdata.add_invamethystingot(1)
		playerdata.load_data()
		
	if item_name == GOLD.name:
		playerdata.add_invGoldIngot(1)
		playerdata.load_data()

	if item_name == LOG.name:
		playerdata.add_invlogingot(1)
		playerdata.load_data()
		
	if item_name == GOLD_GEAR.name:
		playerdata.add_goldgear(1)
		playerdata.add_invGoldIngot(-3)
		playerdata.load_data()

	if item_name == AMETHYST_GEAR.name:
		playerdata.add_amethystgear(1)
		playerdata.add_invamethystingot(-3)
		playerdata.load_data()
				
	if item_name == COBALT_GEAR.name:
		playerdata.add_cobaltgear(1)
		playerdata.add_invironingot(-3)
		playerdata.load_data()
					
	if item_name == OIL.name:
		playerdata.add_oil(1)
		playerdata.add_invlogingot(-6)
		playerdata.load_data()
				
	if item_name == WIRES.name:
		playerdata.add_wires(2)
		playerdata.add_invGoldIngot(-1)
		playerdata.load_data()
				
	if item_name == COMPUTER_CHIP.name:
		playerdata.add_computerchip(1)
		playerdata.add_invGoldIngot(-2)
		playerdata.add_wires(-2)
		playerdata.load_data()
				
	if item_name == TOOLKIT.name:
		playerdata.add_toolkit(1)
		playerdata.add_invstick(-5)
		playerdata.add_invironingot(-2)
		playerdata.load_data()
				
	if item_name == TOOLBOX.name:
		playerdata.add_toolbox(1)
		playerdata.add_goldgear(-2)
		playerdata.add_invironingot(-4)
		playerdata.load_data()
				
	if item_name == GOLD_STICK.name:
		playerdata.add_invlogingot(-2)
		playerdata.add_invstick(1)
		playerdata.load_data()

	if item_name == REMOVE_PARTS.name:
		for slot in inventory_slots:
			if slot.get_child_count() != 0:
				var centre_container = slot.get_children()[1]
				var item = centre_container.get_children()[0].get_children()[0]
				var label = centre_container.get_children()[0].get_children()[1]
				if item.texture == COMPUTER_CHIP.texture:
					label.text = str(int(label.text) - playerdata.invcomputerchip)
					if int(label.text) <= 0:
						label.text = ""
						item.texture = null
				if item.texture == TOOLKIT.texture:
					label.text = str(int(label.text) - playerdata.invtoolkit)
					if int(label.text) <= 0:
						label.text = ""
						item.texture = null
				if item.texture == TOOLBOX.texture:
					label.text = str(int(label.text) - playerdata.invtoolbox)
					if int(label.text) <= 0:
						label.text = ""
						item.texture = null
				if item.texture == OIL.texture:
					label.text = str(int(label.text) - playerdata.invoil)
					if int(label.text) <= 0:
						label.text = ""
						item.texture = null
				if item.texture == GOLD_GEAR.texture: 
					label.text = str(int(label.text) - playerdata.invgoldgear)
					if int(label.text) <= 0:
						label.text = ""
						item.texture = null
				if item.texture == COBALT_GEAR.texture:
					label.text = str(int(label.text) - playerdata.invcobaltgear)
					if int(label.text) <= 0:
						label.text = ""
						item.texture = null
				if item.texture == AMETHYST_GEAR.texture:
					label.text = str(int(label.text) - playerdata.invamethystgear)
					if int(label.text) <= 0:
						label.text = ""
						item.texture = null
				if item.texture == WIRES.texture:
					label.text = str(int(label.text) - playerdata.invwires)
					if int(label.text) <= 0:
						label.text = ""
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


# Signal from playerdata is caught here and updated the inventory based on the amounts present in the save file
func _on_inventory_loaded(gold_amount, iron_amount, 
	log_amount, stick_amount, 
	amethyst_amount, pick_axe_head_amount, 
	pick_axe_amount, toolbox_amount, 
	toolkit_amount, wires_amount, 
	oil_amount, gold_gear_amount, 
	amethyst_gear_amount, cobalt_gear_amount, 
	metal_plate_amount, computer_chip_amount):
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
		player.speed = 100
		for slot in inventory_gui_slots:
			slot.hide()

		
	if not inv_open and not player.is_swinging:
		inv_gui_show.show()
		inv_crafting.show()
		player.speed = 0
		for slot in inventory_gui_slots:
			slot.show()
	inv_open = !inv_open


func _process(delta):
	if Input.is_action_just_pressed("Pause"):
		get_tree().change_scene_to_file("res://scenes/pause_menu.tscn")
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
	if spaceship_entered == true and Input.is_action_just_pressed("g"):
		deposititems()
		if playerdata.spaceship_amethyst_gears >= 5 and playerdata.spaceship_carton_of_oil >= 3 and playerdata.spaceship_cobalt_gears >= 5 and playerdata.spaceship_computer_chip >= 1 and playerdata.spaceship_gold_gears >= 5 and playerdata.spaceship_machine_parts >= 4 and playerdata.spaceship_thruster_repair_kits >= 2 and playerdata.spaceship_wires >= 10:
			_launch_rocket_()
			await get_tree().create_timer(1.5).timeout 
			get_tree().change_scene_to_file("res://end_scene.tscn")
	
	#Updates the items for the spaceship based on how many have been deposited
	var text = ""
	text += "Amethyst Gears: " + str(playerdata.spaceship_amethyst_gears) + "/5\n"
	text += "Cartons of Oil: " + str(playerdata.spaceship_carton_of_oil) + "/3\n"
	text += "Cobalt Gears: " + str(playerdata.spaceship_cobalt_gears) + "/5\n"
	text += "Computer Chips: " + str(playerdata.spaceship_computer_chip) + "/1\n"
	text += "Gold Gears: " + str(playerdata.spaceship_gold_gears) + "/5\n"
	text += "Machine Parts: " + str(playerdata.spaceship_machine_parts) + "/4\n"
	text += "Thruster Repair Kits: " + str(playerdata.spaceship_thruster_repair_kits) + "/2\n"
	text += "Wires: " + str(playerdata.spaceship_wires) + "/10\n"

	rich_text_label.text = text
	
	if Input.is_action_just_pressed("map"):
		mapopen()


# Allows player to deposit items in the spaceship
func deposititems():
	var required_computer_chips = 1
	var required_toolkits = 4
	var required_toolboxes = 2
	var required_oil = 3
	var required_gold_gears = 5
	var required_cobalt_gears = 5
	var required_amethyst_gears = 5
	var required_wires = 10
	

	if playerdata.invcomputerchip >= required_computer_chips:
		playerdata.add_spaceship_computer_chip(required_computer_chips)
		playerdata.add_computerchip(-required_computer_chips)
	else:
		playerdata.add_spaceship_computer_chip(playerdata.invcomputerchip)
		playerdata.add_computerchip(-playerdata.invcomputerchip)

	if playerdata.invtoolkit >= required_toolkits:
		playerdata.add_spaceship_machine_parts(required_toolkits)
		playerdata.add_toolkit(-required_toolkits)
	else:
		playerdata.add_spaceship_machine_parts(playerdata.invtoolkit)
		playerdata.add_toolkit(-playerdata.invtoolkit)
		
	if playerdata.invtoolbox >= required_toolboxes:
		playerdata.add_spaceship_thruster_repair_kits(required_toolboxes)
		playerdata.add_toolbox(-required_toolboxes)
	else:
		playerdata.add_spaceship_thruster_repair_kits(playerdata.invtoolbox)
		playerdata.add_toolbox(-playerdata.invtoolbox)

	if playerdata.invoil >= required_oil:
		playerdata.add_spaceship_carton_of_oil(required_oil)
		playerdata.add_oil(-required_oil)
	else:
		playerdata.add_spaceship_carton_of_oil(playerdata.invoil)
		playerdata.add_oil(-playerdata.invoil)

	playerdata.add_spaceship_metal_plates(playerdata.invmetalplate)
	playerdata.add_metalplate(-playerdata.invmetalplate)

	if playerdata.invgoldgear >= required_gold_gears:
		playerdata.add_spaceship_gold_gears(required_gold_gears)
		playerdata.add_goldgear(-required_gold_gears)
	else:
		playerdata.add_spaceship_gold_gears(playerdata.invgoldgear)
		playerdata.add_goldgear(-playerdata.invgoldgear)

	if playerdata.invcobaltgear >= required_cobalt_gears:
		playerdata.add_spaceship_cobalt_gears(required_cobalt_gears)
		playerdata.add_cobaltgear(-required_cobalt_gears)
	else:
		playerdata.add_spaceship_cobalt_gears(playerdata.invcobaltgear)
		playerdata.add_cobaltgear(-playerdata.invcobaltgear)

	if playerdata.invamethystgear >= required_amethyst_gears:
		playerdata.add_spaceship_amethyst_gears(required_amethyst_gears)
		playerdata.add_amethystgear(-required_amethyst_gears)
	else:
		playerdata.add_spaceship_amethyst_gears(playerdata.invamethystgear)
		playerdata.add_amethystgear(-playerdata.invamethystgear)

	if playerdata.invwires >= required_wires:
		playerdata.add_spaceship_wires(required_wires)
		playerdata.add_wires(-required_wires)
	else:
		playerdata.add_spaceship_wires(playerdata.invwires)
		playerdata.add_wires(-playerdata.invwires)

	playerdata.load_data()


# Highlights slots 
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


func mapopen():
	if mapshow:
		maprough.hide()
	else:
		maprough.show()
	mapshow = !mapshow


func pausemenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale =  1
	else:
		pause_menu.show()
		Engine.time_scale = 0


# Showing the list of items for spaceship 
func _on_spaceshiparea_body_entered(body):
	if body == player:
		spaceship_entered = true
		rich_text_label.show()


func _on_spaceshiparea_body_exited(body):
	if body == player:
		spaceship_entered = false
		rich_text_label.hide()


# Camera limits based on where the player is in the game as well as transitions between areas
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
		await get_tree().create_timer(1).timeout
		player.speed = 100


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


func _on_area_2d_cave_body_entered(body):
	if body == player: 
		cavemusic.play()
		var canvas_modulate = $CanvasModulate2
		canvas_modulate.color = Color(0, 0, 1, 1) 
		var point_light = $Player/Camera2D/PointLight2D
		point_light.visible = true 
		var camera = $Player/Camera2D 
		if camera:
			camera.limit_right = 100000
			camera.limit_left = -40000
			camera.limit_bottom = 100000
			camera.limit_top = -100000


func _on_area_2d_cave_body_exited(body):
	if body == player: 
		cavemusic.stop() 
		var canvas_modulate = $CanvasModulate2
		if canvas_modulate:
			canvas_modulate.color = Color(1, 1, 1, 1) 
		var point_light = $Player/Camera2D/PointLight2D
		if point_light:
			point_light.visible = false  
		var camera = $Player/Camera2D
		camera.limit_right = 2600 
		camera.limit_left = -2000
		camera.limit_bottom = 1000
		camera.limit_top = -1800


# Moves the player off the rocket and initiates the launch sequence, including animations and scene transition.Moves the player slightly to simulate stepping off the rocket during launch preparation.
func _launch_rocket_():
	move_player_off_rocket()
	hide_player()
	player.speed = 0
	var spaceship = $spaceship  
	if spaceship:
		spaceship.visible = false  
	animation_rocket.play("fadein") 
	var rocket_sprite = $Rocket2
	if rocket_sprite:
		rocket_sprite.visible = true  
	await screen_shake()
	await move_rocket_up(rocket_sprite)
	animation_rocket.play("fadein")  
	await _wait_for_animation("fadein")  
	animation_rocket.play("fadeout")
	await _wait_for_animation("fadeout")  
	await get_tree().create_timer(exit_delay).timeout  
	get_tree().change_scene_to_file("res://end_scene.tscn")


# Moves the player slightly to simulate stepping off the rocket during launch preparation.
func move_player_off_rocket():
	if player:
		player.position.x -= 50  


# Hides the player during the launch
func hide_player():
	if player:
		player.visible = false  


# Shakes the camera to give effect of rocket taking off
func screen_shake():
	var camera = $Player/Camera2D  
	if camera:
		for i in range(10):  
			var shake_offset = Vector2(randi() % screen_shake_strength, randi() % screen_shake_strength)
			camera.offset = shake_offset
			await get_tree().create_timer(0.05).timeout
		camera.offset = Vector2(0, 0)  


# Moves rocket sprite up and off of the screen
func move_rocket_up(sprite):
	var sprite_frames = sprite.sprite_frames  
	if sprite_frames:
		var frame_size = sprite_frames.get_frame_texture(sprite.animation, 0).get_size()  
		while sprite.position.y > -frame_size.y:  
			sprite.position.y -= move_speed * get_process_delta_time()  
		sprite.visible = false


# Waits for animations to finish before allowing others to continue
func _wait_for_animation(anim_name):
	if animation_rocket:
		await animation_rocket.animation_finished  


# Plays music based on area
func _on_area_2d_music_body_entered(body):
	if body == player:
		music.play()

# Stops music based on area
func _on_area_2d_music_body_exited(body):
	if body == player:
		music.stop()


# Transitions player to main once entering cave entrance
func _on_cavetomain_body_entered(body):
	if body == player: 
		player.speed = 0
		animation_player.play("fadein")
		player.global_position = cavetomainmarker.global_position
		animation_player.play("fadeout")
		await get_tree().create_timer(1).timeout
		player.speed = 100
