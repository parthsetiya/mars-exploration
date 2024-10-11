extends Resource
class_name PlayerData

@export var speed = 100
@export var health = 100
#@export var current_item: String

var data = {}

var file_json = "res://Inventory/saveitems.json"

@export var SavePos : Vector2
var invironingot : int
var invGoldIngot : int
var invlogingot : int
var invstick : int
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
	#print("saving data...")
	var data = {
		"gold_amount": invGoldIngot,
		"iron_amount": invironingot,
		"log_amount": invlogingot,
		"stick_amount": invstick,
		"position": [SavePos.x, SavePos.y]  
	}
	
	var json = JSON.new()
	var json_string = json.stringify(data)
	var file = FileAccess.open("res://Inventory/saveitems.json", FileAccess.WRITE)
	file.store_line(json_string)
	file.close()
	#print("Data saved to res://Inventory/saveitems.json")
	
	jsongoldvalue = data["gold_amount"]
	jsonironvalue = data["iron_amount"]
	jsonlogvalue = data["log_amount"]
	jsonstickvalue = data["stick_amount"]


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
	jsongoldvalue = data["gold_amount"]
	jsonironvalue = data["iron_amount"]
	jsonlogvalue = data["log_amount"]
	jsonstickvalue = data["stick_amount"]
	invlogingot = jsonlogvalue
	invironingot = jsonironvalue
	invGoldIngot = jsongoldvalue
	invstick = jsonstickvalue

	emit_signal("inventory_loaded", invGoldIngot, invironingot, invlogingot, invstick)
	
	var pos_array = data["position"]
	SavePos = Vector2(pos_array[0], pos_array[1])
	
	 


