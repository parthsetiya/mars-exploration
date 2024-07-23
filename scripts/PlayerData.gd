extends Resource
class_name PlayerData

@export var speed = 100
@export var health = 100


@export var invGoldIngot = 0 
@export var SavePos : Vector2
@export var invironingot = 0 

func add_invGoldIngot(value : int):
	invGoldIngot += value
	print("running add gold ingot")
	print("no of gold: " + str(invGoldIngot))
	save()  # Save after adding gold

func add_invironingot(value : int):
	invironingot += value
	print("adding iron ingot")
	print("no of iron: " + str(invironingot))
	save()  # Save after adding iron

func get_iron():
	return invironingot

func remove_invGoldIngot(value : int):
	invGoldIngot -= value
	print("running remove gold ingot")
	print("new no of gold: " + str(invGoldIngot))
	save()  # Save after removing gold

func change_health(value : int):
	health += value

func UpdatePos(value : Vector2):
	SavePos = value 
	
func save():
	print("Saving data...")
	print("Gold ingots:", invGoldIngot)
	print("Iron ingots:", invironingot)
	var data = {
		"gold_amount" : invGoldIngot,
		"iron_amount" : invironingot,
	}
	
	var json = JSON.new()
	var json_string = json.stringify(data)
	var file = FileAccess.open("res://Inventory/saveitems.json", FileAccess.WRITE)
	file.store_line(json_string)
	file.close()
	print("Data saved to res://Inventory/saveitems.json")

func load_data():
	print("Loading data...")
	var file = FileAccess.open("res://Inventory/saveitems.json", FileAccess.READ)
	if file:
		var json_string = file.get_as_text().strip_edges()
		file.close()
		
		var json = JSON.new()
		var data = json.parse_string(json_string)
		if data.error == OK:
			var dict = data.result
			invGoldIngot = dict["gold_amount"]
			invironingot = dict["iron_amount"]
			print("Loaded data:")
			print("Gold ingots:", invGoldIngot)
			print("Iron ingots:", invironingot)
		else:
			print("Failed to parse JSON.")
	else:
		print("Failed to open save file.")
