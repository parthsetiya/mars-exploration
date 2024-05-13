extends Control

@onready var inv: Inv = preload("res://Inventory/playerinv.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

func update_slots():
	for i in range(min(inv.items.size(), slots.size())):
		slots[i].update(inv.items[i])
		
		

func _ready():
	for i in range(min(inv.items.size(), slots.size())):
		slots[i].update(inv.items[i]) 
		print(inv.items[i])
