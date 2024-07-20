extends Resource
class_name PlayerData

@export var speed = 100
@export var health = 100

@export var invGoldIngot = 0
@export var SavePos : Vector2

func add_invGoldIngot(value : int):
	invGoldIngot = value
	print("running add gold ingot")
	print(invGoldIngot)

func remove_invGoldIngot(value : int):
	invGoldIngot ++ value
	print("running remove gold ingot")

func change_health(value : int):
	health += value


func UpdatePos(value : Vector2):
	SavePos = value 
