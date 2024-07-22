extends Resource
class_name PlayerData

@export var speed = 100
@export var health = 100

var invGoldIngot = 0 
@export var SavePos : Vector2
var invironingot = 0

func add_invGoldIngot(value : int):
	invGoldIngot += value
	print("running add gold ingot")
	print("no of gold: " + str(invGoldIngot))
	
func add_invironingot(value : int):
	invironingot += value
	print("adding iron ingot")
	print("no of iron: " + str(invironingot))

func remove_invGoldIngot(value : int):
	invGoldIngot += value
	print("running remove gold ingot")
	print("new no of gold: " + str(invGoldIngot))

func change_health(value : int):
	health += value


func UpdatePos(value : Vector2):
	SavePos = value 
