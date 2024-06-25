extends CharacterBody2D

class_name Player

@onready var animations = $AnimationPlayer
@onready var gold_block = $gold_block


@onready var deathscreen = $Deathscreen
@onready var death_screen_color_rect = $Deathscreen/ColorRect

var GOLD = load("res://Inventory/items/gold.tres")

var speed = 100
var health = 100
var inv_open = false

var save_file_path = "user://save/"
var save_file_name = "PlayerSave.tres"
var playerData = PlayerData.new()
var inventory = Inventory.new()
@onready var inventory_gui = $InventoryGui
signal update_ui(health, position)
#added reswawn location needs to be changed to last save location
var respawn_position = Vector2(playerData.SavePos)

# Node definitions
var gold_node
var inventory_slots
var first_slot_index = null
var second_slot_index = null

func _ready():
	verify_save_directory(save_file_path)
	gold_node = get_node("gold_block")
	gold_node.connect("request_inventory_update", Callable(self, "_on_request_inventory_update"))
	inventory_gui.connect("slot_clicked", Callable(self, "_on_slot_clicked"))
	inventory_slots = get_node("InventoryGui/NinePatchRect/GridContainer").get_children()

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
	# Iterate through inventory slots to find if gold is already in a slot
	for i in range(inventory_slots.size()):
		var slot = inventory_slots[i]
		var centre_container = slot.get_children()[1]
		var item = centre_container.get_children()[0].get_children()[0]
		var label = centre_container.get_children()[0].get_children()[1]

		if item.texture == GOLD.texture:
			label.text = str(updated_quantity)
			return 

	# If no gold was found in any slot, add gold to the first available slot
	for i in range(inventory_slots.size()):
		var slot = inventory_slots[i]
		var centre_container = slot.get_children()[1]
		var item = centre_container.get_children()[0].get_children()[0]
		var label = centre_container.get_children()[0].get_children()[1]

		
		if item.texture == null: 
			item.texture = GOLD.texture
			label.text = str(updated_quantity)
			return 

	
	
	
func verify_save_directory(path: String):
	DirAccess.make_dir_absolute(path)
	
func _process(delta):
	position += velocity * delta
	if Input.is_action_just_pressed("save"):
		save()
	if Input.is_action_just_pressed("load"):
		load_data()
	#emit_signal("update_ui", playerData.health, self.position)
	emit_signal("update_ui", playerData.health, self.position)
	playerData.UpdatePos(self.position)
	if Input.is_action_just_pressed("Inventory"):
		inventoryopen()
	$Goldcounter.text = "Gold: %s" % playerData.invGoldIngot


#checks players health
func check_health():
	print("checking health")
	if playerData.health >= 0:
		print("health removal worked running player death")
		on_player_death()

func on_player_death():
	deathscreen.show()
	print("showing deathscreen")
	#death_screen_color_rect.modulate = Color(0, 0, 0, 0)  # Set initial color to transparent
	$AnimationPlayer.play("fade_in")  # Play the fade-in animation
	print("playing fade_in")
	await get_tree().create_timer(2.0).timeout  # Show death screen for 2 seconds
	respawn()

func respawn():
	print("respawn function running")
	deathscreen.hide()
	self.position = respawn_position
	playerData.change_health(+100) 
	print(playerData.health)  # Reset health or any other parameters

func load_data():
	playerData = ResourceLoader.load(save_file_path + save_file_name). duplicate(true)
	on_start_load()
	print("loaded data")
	
func on_start_load():
	self.position = playerData.SavePos

func save():
	ResourceSaver.save(playerData, save_file_path + save_file_name)
	print("saved data")

func take_damage():
	playerData.change_health(-5)
	
func gain_health():
	playerData.change_health(5)

func _on_control_change_health(action):
	if action == "+":
		gain_health()
	elif action == "-":
		take_damage()


	
func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func updateAnimation():
	if velocity.length() == 0: 
		animations.stop()
		
	else: 
		var direction = "Down"
		if velocity.x < 0: direction = "Left"
		elif velocity.x > 0: direction = "Right"
		elif velocity.y < 0: direction = "Up"
		elif velocity.y < 0: direction = "Idle"

		animations.play("walk" + direction)

func _physics_process(delta):
	get_input()
	move_and_slide()
	updateAnimation()
	
func inventoryopen():
	if inv_open:
		inventory_gui.hide()
	else:
		inventory_gui.show()
	inv_open = !inv_open 
	

