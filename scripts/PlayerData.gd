extends Resource
class_name PlayerData

@export var speed = 100
@export var health = 100

@export var SavePos : Vector2

func change_health(value : int):
	health += value


func UpdatePos(value : Vector2):
	SavePos = value 
