extends Resource
class_name PlayerData

@export var speed = 100
@export var health = 100

var data = {}

var file_json = "res://Inventory/saveitems.json"

@export var SavePos : Vector2
var invironingot : int
var invGoldIngot : int
var invlogingot : int
var invstick : int
var invpickaxe : int
var invpickaxehead : int
var invtoolbox : int
var invtoolkit : int
var invwires : int
var invoil : int
var invgoldgear : int
var invamethystgear : int
var invcobaltgear : int

var xvaluesave
var yvaluesave
var player = preload("res://scenes/player.tscn")
var current_item
var recieved_glove = false

@export var jsongoldvalue : int
var jsonironvalue
var jsonlogvalue
var jsonstickvalue

signal inventory_loaded(gold_amount, iron_amount, log_amount)

func updatecurrent_item(value):
	current_item = value
	print(current_item)

# Add functions for the new items

func add_invGoldIngot(value : int):
	invGoldIngot += value
	save()

func add_invironingot(value : int):
	invironingot += value
	save()

func add_invlogingot(value : int):
	invlogingot += value
	save()

func add_invstick(value: int):
	invstick += value
	save()

func add_pickaxe(value: int):
	invpickaxe += value
	print("this much invpickaxe: ", invpickaxe)
	save()

func add_pickaxehead(value: int):
	invpickaxehead += value
	save()

func add_toolbox(value: int):
	invtoolbox += value
	save()

func add_toolkit(value: int):
	invtoolkit += value
	save()

func add_wires(value: int):
	invwires += value
	save()

func add_oil(value: int):
	invoil += value
	save()

func add_goldgear(value: int):
	invgoldgear += value
	save()

func add_amethystgear(value: int):
	invamethystgear += value
	save()

func add_cobaltgear(value: int):
	invcobaltgear += value
	save()

func remove_invGoldIngot(value : int):
	invGoldIngot -= value
	print("running remove gold ingot")
	print("new no of gold: " + str(invGoldIngot))
	save()

func change_health(value : int):
	health += value

func UpdatePos(value : Vector2):
	SavePos = value
	save()

func save():
	var data = {
		"gold_amount": invGoldIngot,
		"iron_amount": invironingot,
		"log_amount": invlogingot,
		"stick_amount": invstick,
		"position": [SavePos.x, SavePos.y],
		"pick-axe_amount": invpickaxe,
		"pick-axe-head_amount": invpickaxehead,
		"toolbox_amount": invtoolbox,
		"toolkit_amount": invtoolkit,
		"wires_amount": invwires,
		"oil_amount": invoil,
		"gold_gear_amount": invgoldgear,
		"amethyst_gear_amount": invamethystgear,
		"cobalt_gear_amount": invcobaltgear
	}
	
	var json = JSON.new()
	var json_string = json.stringify(data)
	var file = FileAccess.open("res://Inventory/saveitems.json", FileAccess.WRITE)
	file.store_line(json_string)
	file.close()

func load_data():
	if not FileAccess.file_exists("res://Inventory/saveitems.json"):
		save()  # Save default data if file doesn't exist
		return

	var file = FileAccess.open("res://Inventory/saveitems.json", FileAccess.READ)
	var file_data = JSON.parse_string(file.get_as_text())
	file.close()
	
	data = file_data
	print("Loaded data:" + str(data))
	
	# Load inventory values
	invGoldIngot = data["gold_amount"]
	invironingot = data["iron_amount"]
	invlogingot = data["log_amount"]
	invstick = data["stick_amount"]
	invpickaxehead = data["pick-axe-head_amount"]
	invpickaxe =  data["pick-axe_amount"]
	invtoolbox = data["toolbox_amount"]
	invtoolkit = data["toolkit_amount"]
	invwires = data["wires_amount"]
	invoil = data["oil_amount"]
	invgoldgear = data["gold_gear_amount"]
	invamethystgear = data["amethyst_gear_amount"]
	invcobaltgear = data["cobalt_gear_amount"]

	emit_signal("inventory_loaded", invGoldIngot, invironingot, invlogingot, invstick, invpickaxehead, invpickaxe, invtoolbox, invtoolkit, invwires, invoil, invgoldgear, invamethystgear, invcobaltgear)
	
	var pos_array = data["position"]
	SavePos = Vector2(pos_array[0], pos_array[1])
