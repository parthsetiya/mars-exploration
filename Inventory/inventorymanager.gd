extends Node

@export var inventory_resource: Resource

func _ready():
	inventory_resource = preload("res://Inventory/playerinventory.tres")
